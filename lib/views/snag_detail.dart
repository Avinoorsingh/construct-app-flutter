import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:colab/views/activity_head.dart';
import 'package:colab/views/sub_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/photos_network.dart';

class SnagDetail extends StatefulWidget {
  SnagDetail({Key? key, this.from, this.snagModel }) : super(key: key);

 final from;
 dynamic snagModel;
  @override
  State<SnagDetail> createState() => _SnagState();
}

class _SnagState extends State<SnagDetail> {
  late String subV="";
  late String subSubV="";
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final remarkController = TextEditingController();
  final deSnagRemarkController=TextEditingController();
  final markController=TextEditingController();
  final debitToController=TextEditingController();
  final debitAmountController=TextEditingController();
  final snagAssignedByController=TextEditingController();
  final snagAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
  final location = ["Select Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue = 'Select Location';  
  final location2 = ["Select Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue2 = 'Select Sub Location';  
  final location3 = ["Select Sub Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue3 = 'Select Sub Sub Location';  
  final debitTo = ["Select Debit to", "Person 1", "Person 2", "Person 3", "Person 4"];
  String dropdownvalueDebitTo = 'Select Debit to';  
  final assignedTo=["Select Name","Name 1"];
  String dropdownvalueAssignedTo="Select Name";
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);

   List<File> _imageList = [];
   List<String> imageData=[];

  void _addImage(File _image) {
    setState(() {
      _imageList.add(_image);
    });
  }
   void _addImageData(String _imagepath) {
    setState(() {
      imageData.add(_imagepath);
    });
  }
 
   List<bool> isCardEnabled = [];
   List<bool> isCardEnabled2 = [];
   List<String> category=[
    "Safety",
    "Execution",
    "Quality",
   ];
   List<String> priority=[
    "Critical",
    "Major",
    "Minor",
   ];
  List viewpoints=[];
  List deSnagImage=[];
  List viewpointID=[];
  final photos = PhotosNetwork();
  File? image;
  CroppedFile? croppedFile;
  var groupedViewpoints = {};
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  croppedFile = await ImageCropper().cropImage(
    sourcePath: image!.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: Colors.white,
          toolbarWidgetColor: const Color.fromRGBO(255, 192, 0, 1),
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit Image',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  var imageTemp = File(croppedFile!.path);
setState(() => this.image = imageTemp);
    } catch(e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
    late List<bool> isSelected;
    final creationController = TextEditingController();
     List viewpoints2=[];
     var array2=[];
    @override
  void initState() {
    super.initState(); 
    isSelected=[true,false,false];
    creationController.text=widget.snagModel?.createdAt??"";
    categoryController.text=widget.snagModel?.category?.name??"";
    locationController.text=widget.snagModel?.location.locationName??"";
    subLocationController.text=widget.snagModel?.subLocation.subLocationName??"";
    subSubLocationController.text=widget.snagModel?.subSubLocation.subSubLocationName??"";
    if(widget.snagModel?.contractorInfo!=null){
    contractorInput.text=widget.snagModel?.contractorInfo?.ownerName??"";
    }
    markController.text=widget.snagModel?.markupFile??"";
    remarkController.text=widget.snagModel?.remark??"";
    deSnagRemarkController.text=widget.snagModel?.deSnagRemark??"";
    debitToController.text="";
    debitAmountController.text=widget.snagModel.debitAmount.toString();
    snagAssignedByController.text="";
    snagAssignedToController.text=widget.snagModel?.employee.name??"";
    priorityController.text=widget.snagModel?.snagPriority;
    if(widget.snagModel?.snagViewpoint.length!=0 && widget.snagModel?.snagViewpoint!=null){
      for(int i=0;i<widget.snagModel?.snagViewpoint.length;i++){
        viewpoints.add({'fileName': widget.snagModel.snagViewpoint[i].viewpointFileName,'image':[],'id':widget.snagModel.snagViewpoint[i].id,'deSnagImage':[]});
        if(!viewpointID.contains(widget.snagModel.snagViewpoint[i].viewpointId)){
        viewpointID.add(widget.snagModel.snagViewpoint[i].id);
        }
      }
    }

     for (var map in viewpoints) {
    // Check if the viewpoints is already in the map
    if (groupedViewpoints.containsKey(map['id'])) {
      // If it is, add the name to the list of names for that viewpoint
      groupedViewpoints[map['id']]?.add(map['fileName']);
    } else {
      // If it isn't, create a new list of names for that viewpoint and add the name
      groupedViewpoints[map['id']] = [map['fileName']];
    }
  }

    // print("I am here, here is the viewpoint");
    // print(groupedViewpoints);
    dateInput.text =getFormatedDate(DateTime.now().toString());
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
    final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
    }
 
   void clearCache()async{
    EasyLoading.show();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
       // ignore: use_build_context_synchronously
       context.pushNamed('LOGINPAGE');
      }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
   // print(dropDownNotifier.value);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
      title: Text("Snag",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Row(children: [
             Text("Snag Creation Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse('${creationController.text}'))}",style: textStyleBodyText1,),
            ])
          ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(categoryController.text.isEmpty?"Category":categoryController.text,style: textStyleBodyText1,),),
              const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"Location":locationController.text,style: textStyleBodyText1,),),
             const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"Sub Location":subLocationController.text,style: textStyleBodyText1,),),
            const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subSubLocationController.text.isEmpty?"Sub Sub Location":subSubLocationController.text,style: textStyleBodyText1,),),
            const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text(contractorInput.text.isEmpty?"Contractor":contractorInput.text,style: textStyleBodyText1,),),
            ])
          ),
          if(markController.text.isNotEmpty && markController.text!=null)
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text("Mark Location",style: textStyleBodyText1,),),
            Center(child:  Card(
            child:
            GestureDetector(
            onTap: () async {
              print(markController.text);
              await showDialog(
                useSafeArea: true,
                context: context,
                builder: (_) => imageDialog('My Image',markController.text.isEmpty?"assets/images/user_fill.png":'http://nodejs.hackerkernel.com/colab${markController.text}', context));
              },
            child: 
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("http://nodejs.hackerkernel.com/colab${markController.text}"),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
          ),
            )
          ),
          ),
            const Divider(color: Colors.grey,), 
            if(groupedViewpoints.isNotEmpty)...{
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text("View Points",style: textStyleBodyText1,),)
            ]),
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: groupedViewpoints.keys.length,
          itemBuilder: (BuildContext context, int outerIndex) {
             var outerKey = groupedViewpoints.keys.toList()[outerIndex];
            return Column(
              children: [
                const SizedBox(height: 20,),
                Row(children: [
                  Text("VIEWPOINT: $outerIndex",style: textStyleBodyText1,)
                ],),
                const SizedBox(height: 10,),
                // IntrinsicHeight(
                //   child:
                  Container(
                    // margin: const EdgeInsets.only(left:20,right: 20),
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow:  [
                      BoxShadow(color:Colors.grey[300]!, spreadRadius: 1),
                    ],
                  ),
                    child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("Snag Image",style: textStyleBodyText1,),),
                      Container(
                        // height: 200,
                        width: 100,
                        child:
                         ListView.builder(
                        // padding: const EdgeInsets.only(bottom: 10,right: 120),
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                          itemCount: groupedViewpoints[outerKey]?.length,
                          itemBuilder: (context, innerIndex) {
                            return
                        GestureDetector(
                      onTap: () async {
                        await showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (_) => imageDialog('Snag Image','https://nodejs.hackerkernel.com/colab${groupedViewpoints[outerKey][innerIndex]}' , context));
                        },
                      child: 
                      SizedBox(
                        height: 100,
                        width: 50,
                        child: Image.network("https://nodejs.hackerkernel.com/colab${groupedViewpoints[outerKey][innerIndex]}"),
                        )
                      );
                          }
                         )
                      )
                    ],
                  ),
                  VerticalDivider(color:Colors.grey[500],thickness: 1,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(child: Text("De-Snag Image",style: textStyleBodyText1,),),
                       GestureDetector(
                      onTap: () async {
                        await showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (_) => imageDialog('Snag Image',"assets/images/activites.png" , context));
                        },
                      child: 
                      Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 viewpoints[outerIndex]['deSnagImage'].isEmpty?
                   Container(
                    margin: const EdgeInsets.all(10),
                  width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(173, 57, 54, 54),Color.fromARGB(250, 19, 14, 14)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: widget.from!='new'?
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      final File imagefile = File(image!.path);
                      viewpoints[outerIndex]['deSnagImage'].add(imagefile);
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        var token=sharedPreferences.getString('token');
                        FormData formData=FormData(); 
                        var dio = Dio();
                        formData.fields.add(MapEntry('viewpoint_id', viewpoints[outerIndex]['id'].toString()));
                        formData.files.add(
                        MapEntry("de_snag_image", await MultipartFile.fromFile(viewpoints[outerIndex]['deSnagImage'][0].path.split(': ')[0].substring(1,viewpoints[outerIndex]['deSnagImage'][0].path.split(': ')[0].length), filename: 'de_snag_image')));
                         var response1=await dio.post("http://nodejs.hackerkernel.com/colab/api/de_snags_image",
                        data:formData,
                        options: Options(
                            followRedirects: false,
                            validateStatus: (status) {
                              return status! < 500;
                            },
                            headers: {
                              "authorization": "Bearer ${token!}",
                              "Content-type": "application/json",
                            },
                          ),
                        );
                           setState(() { });
                        if (kDebugMode) {
                          print(response1);
                        }
                  },
                  child: const Center(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ): Container()
              ):
                  SizedBox(
                   height: 100,
                   width: 50,
                   child:
                  InkWell(
                      onTap: () {
                        // print(viewpoints);
                        return;
                      },
                          child:
                          FittedBox(
                           child:
                           Container(
                            margin: const EdgeInsets.only(top:10,bottom: 10),
                            height: 100,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image:DecorationImage(
                                image:FileImage(File(viewpoints[outerIndex]['deSnagImage'][0].path?? "")),
                              fit: BoxFit.cover,
                              ),
                            )
                          )
                        )
                      )
                    ),
                  ]
                ),
              ),
            ],
          ),
        ]
      )
                  // ),
                ),
              ],
            );
          }),
            }
            ])
            ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("REMARK",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: false,
              controller: remarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
            if(widget.from!="desnagnew")
              Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DE-SNAG REMARK",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: false,
              controller: deSnagRemarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
              Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT TO",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: false,
              // controller: priorityController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                suffixIcon:const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,),
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                  disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),

              Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT AMOUNT",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: false,
              controller: debitAmountController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
               ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
              Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("SNAG ASSIGNED BY",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: false,
              controller: snagAssignedByController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                suffixIcon:const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,),
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
               ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
              Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("SNAG ASSIGNED TO",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: false,
              controller: snagAssignedToController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                suffixIcon:const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,),
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                 disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(
              children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Snag Priority",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
           SizedBox(
            height: 75,child: 
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 15,bottom: 15,left: 0,right: 0),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled2.add(false);
            return GestureDetector(
                onTap: (){
                  // print(priority[index].toString().substring(0,2).toUpperCase());
                },
                child: SizedBox(
                  height: 10,
                  width: 100,
                  child: Container(
                   decoration: BoxDecoration(
                     color: priority[index].toString().substring(0,2).toUpperCase()==priorityController.text? const Color.fromRGBO(255, 192, 0, 1):Colors.white,
                     border: Border.all(width: 1.2,color:  const Color.fromRGBO(255, 192, 0, 1),),
                    ),
                    child: Center(
                      child: Text(priority[index],textAlign: TextAlign.center,
                        style: TextStyle(
                            color: priority[index].toString().substring(0,2).toUpperCase()==priorityController.text?Colors.black: const Color.fromRGBO(255, 192, 0, 1),
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
          ),
          ]),
            ),
            if(widget.from=="desnagnew")...{
                  Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DE-SNAG REMARK",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
            TextField(
              enabled: true,
              controller: deSnagRemarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: null,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
          ])
            ),
                Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: Colors.white
              ),
              child: const Text("Cancel",style: TextStyle(color: Colors.black),)),
                ElevatedButton(onPressed: ()
                   async{
                // List VID=[];
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var createdById=sharedPreferences.getString('id');
                // FormData formData=FormData(); 
                // var dio = Dio();
                // List viewpointsToSent=[];
                // if(viewpoints.isNotEmpty){
                // for(int i=0;i<viewpoints.length;i++){
                //   if(viewpoints[i]['deSnagImage'].isNotEmpty){
                //   for(int j=0;j<viewpoints[i]['deSnagImage'].length;j++){
                //     viewpointsToSent.add(viewpoints[i]['deSnagImage'][j].toString());
                //   }
                //   }
                // }
                // }
                // if(viewpointsToSent.isNotEmpty){
                // for (var item in viewpointsToSent){
                //       formData.fields.add(MapEntry('viewpoint_id', '${viewpointID[viewpointsToSent.indexOf(item)]}'));
                //       formData.files.add(
                //       MapEntry("de_snag_image", await MultipartFile.fromFile(viewpointsToSent[viewpointsToSent.indexOf(item)].split(': ')[1].substring(1,viewpointsToSent[viewpointsToSent.indexOf(item)].split(': ')[1].length-1), filename: 'de_snag_image'))
                //     );
                // }
                // try {
                // var response1=await dio.post("http://nodejs.hackerkernel.com/colab/api/de_snags_image",
                // data:formData,
                // options: Options(
                //     followRedirects: false,
                //     validateStatus: (status) {
                //       return status! < 500;
                //     },
                //     headers: {
                //       "authorization": "Bearer ${token!}",
                //       "Content-type": "application/json",
                //     },
                //   ),
                // );
                // print(response1);    
                // } catch (e) {
                //   print(e);
                // }
                // }
                // formData.fields.add(const MapEntry('markup_file', ''));
                // formData.fields.add(MapEntry('snags_data', jsonEncode({
                //        "client_id":widget.snagModel.id,
                //       "project_id":widget.snagModel.projectId,
                  //     "category_id": widget.snagModel.categoryId,
                  //     "location_id": widget.snagModel.locationId,
                  //     "sub_loc_id":widget.snagModel.subLocId,
                  //     "sub_sub_loc_id": widget.snagModel.subSubLocId,
                  //     "activity_head_id": widget.snagModel.activityHeadId,
                  //     "activity_id":widget.snagModel.activityId,
                  //     "contractor_id": widget.snagModel.contractorId, 
                  //     "remark": widget.snagModel.remark,
                  //     "debit_note":widget.snagModel.debitNote,
                  //     "debit_amount":widget.snagModel.debitAmount,
                  //     "due_date": widget.snagModel.dueDate,
                  //     "assigned_to": widget.snagModel.assignedTo,
                  //     "created_by": 23,
                  //     "snag_status": widget.from=="desnagnew"?"O":"N",
                  //  }
                  //  )
                  //  )
                  //  );
                  try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": widget.from=="desnagnew"?"O":"N",
                            }
                            );
                    print(res.statusCode);
                    EasyLoading.showToast("Sent for review",toastPosition: EasyLoadingToastPosition.bottom);          
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     print(e); 
                    }
                },
                style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: const Color.fromARGB(255, 91, 235, 96)
              ), 
                child: const Text("Send For Review"),
                )
              ],)
                )
            },
               if(widget.from=="openedSnag")...{
                  Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            child: 
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () async{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var createdById=sharedPreferences.getString('id');
                   try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": "CWD",
                            }
                          );
                    print(res.statusCode);
                    EasyLoading.showToast("Closed with debit",toastPosition: EasyLoadingToastPosition.bottom);          
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     print(e); 
                    }
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: Colors.white
              ),
              child: const Text("Close with debit",style: TextStyle(color: Colors.black),)),
                  ElevatedButton(onPressed: ()async{
               SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var createdById=sharedPreferences.getString('id');
                   try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": "C",
                            }
                            );
                    print(res.statusCode);
                    EasyLoading.showToast("Closed with debit",toastPosition: EasyLoadingToastPosition.bottom);          
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     print(e); 
                    }
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: Colors.white
              ),
              child: const Text("Close without debit",style: TextStyle(color: Colors.black),)),
              ],),
                const SizedBox(height: 10,),
                  ElevatedButton(onPressed: ()async{
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var createdById=sharedPreferences.getString('id');
                   try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": "N",
                            }
                            );
                    print(res.statusCode);
                    EasyLoading.showToast("Rejected",toastPosition: EasyLoadingToastPosition.bottom);          
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     print(e); 
                    }
                  },
                style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: const Color.fromARGB(255, 233, 78, 129)
              ), 
                child: const Text("Reject",style: TextStyle(color: Colors.black),),
                )
              ]
            )
          )
        }
      ]
    )
   )
  );
}
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SubLocation(),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
  );
}


Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ActivityHeadPage(),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
  );
}


Widget imageDialog(text, path, context) {
return Dialog(
  backgroundColor: Colors.transparent,
  elevation: 0,
  child: Column(
    children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              style: ElevatedButton.styleFrom(backgroundColor:  const Color.fromRGBO(255, 192, 0, 1),),
              child: const Text("CANCEL",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.2,
        child: Image.network(
          '$path',
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
);}
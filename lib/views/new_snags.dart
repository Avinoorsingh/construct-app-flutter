import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../theme/text_styles.dart';

class NewSnag extends StatefulWidget {
  const NewSnag({Key? key,}) : super(key: key);

  @override
  State<NewSnag> createState() => _NewSnagState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;
// ignore: prefer_typing_uninitialized_variables
var update;

class _NewSnagState extends State<NewSnag> {
  final getSnag = Get.find<GetNewSnag>();
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  var outputFormat = DateFormat('dd/MM/yyyy');
  var outputFormat1 = DateFormat('dd/MM/yyyy');
  final signInController=Get.find<SignInController>();
 
 @override
 void initState(){
  super.initState();
  getSnag.getSnagData(context: context);
  if (kDebugMode) {
    print("here 11");
  }
  if(signInController.getSnagDataList!.data!.isNotEmpty && subLocationName.isEmpty){
    for(int i=0;i<signInController.getSnagDataList!.data!.length;i++){
       subLocationName.add(signInController.getSnagDataList!.data![i].subLocation!.subLocationName);
       subSubLocationName.add(signInController.getSnagDataList!.data![i].subSubLocation!.subSubLocationName);
       locationName.add(signInController.getSnagDataList!.data![i].location!.locationName);
       remark.add(signInController.getSnagDataList!.data![i].remark);
       dueDates.add(signInController.getSnagDataList!.data![i].dueDate);
       createdDates.add(signInController.getSnagDataList!.data![i].createdAt);
       snagData.add(signInController.getSnagDataList!.data![i]);
       dateDifference.add(DateTime.parse(signInController.getSnagDataList!.data![i].dueDate!).difference(DateTime.parse(signInController.getSnagDataList!.data![i].createdAt!)).inDays);
      }
    }
  EasyLoading.dismiss();
 }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context2) {
    if (kDebugMode) {
      print("rebuild");
    }
    return 
    Scaffold(
    resizeToAvoidBottomInset: false,
    body:
    Container(
    margin: const EdgeInsets.only(top: 110),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subLocationName.length,
              itemBuilder: (BuildContext context, int index){
                return 
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: 
                    Column(
                      children:[
                        Center(child: 
                        Stack(
                          clipBehavior: Clip.none,
                          children: [ 
                            InkWell(
                            splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  show=!show;
                                  tapped=index;
                                });
                              },
                              child:
                            Card(
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 335,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${subLocationName[index]} / ${subSubLocationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),),
                                    Text("${locationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text("Date: ${outputFormat1.format(DateTime.parse(createdDates[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      Text("Due Date: ${outputFormat.format(DateTime.parse(dueDates[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                  ],),
                            )),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 320,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child:  Center(
                                  child:  Container(
                                    width: 30.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color:dateDifference[index]<0?Colors.red:dateDifference[index]==0?Colors.green:AppColors.primary,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(child:
                                    Text(dateDifference[index].toString(),style: textStyleBodyText1.copyWith(fontSize: 12),)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      if(show==true && index==tapped)
                        Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: 330,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                            child:InkWell(
                              onTap: (){
                                context.pushNamed('SNAGDETAIL',
                                queryParams: {"from": "new"},
                                extra: snagData[index]);
                              },
                              child: 
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text("Snag Remark: ",style: textStyleHeadline4,overflow: TextOverflow.ellipsis,),
                              Text((remark[index]!=null? (remark[index]!.length>30?"${remark[index]!.substring(0,29)}...":remark[index] ?? ""):""),style: textStyleBodyText2,overflow: TextOverflow.ellipsis,),
                             ],)
                            )
                            ),
                            ]
                          )
                        );
                    }
                  )
        ),
      ],
    )),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).pushNamed('ADDSNAG');
          context.pushNamed('ADDSNAG');
        },
        backgroundColor:AppColors.primary,
        child: const Icon(Icons.add, color: Colors.black,),
      ),
    );
  }
}
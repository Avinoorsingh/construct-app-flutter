import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../theme/text_styles.dart';

class ClosedDeSnags extends StatefulWidget {
  const ClosedDeSnags({Key? key}) : super(key: key);

  @override
  State<ClosedDeSnags> createState() => _NewSnagState();
}

bool show=false;
late var tapped;

class _NewSnagState extends State<ClosedDeSnags> {
  final getSnag = Get.find<GetClosedSnag>();
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List<String?> deSnagRemark=[];
  List<String?> closingDeSnagRemark=[];
  List snagData=[];
  List dateDifference=[];
 
 @override
 void initState(){
  super.initState();
  getSnag.getClosedSnagData(context: context);
 }

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat1 = DateFormat('dd/MM/yyyy h:mm a');
    return GetBuilder<GetClosedSnag>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getSnagDataClosedList!.data!.isNotEmpty && subLocationName.isEmpty){
      for(int i=0;i<signInController.getSnagDataClosedList!.data!.length;i++){
       subLocationName.add(signInController.getSnagDataClosedList!.data![i].subLocation!.subLocationName);
       subSubLocationName.add(signInController.getSnagDataClosedList!.data![i].subSubLocation!.subSubLocationName);
       locationName.add(signInController.getSnagDataClosedList!.data![i].location!.locationName);
       remark.add(signInController.getSnagDataClosedList!.data![i].remark);
       deSnagRemark.add(signInController.getSnagDataClosedList!.data![i].deSnagRemark);
       closingDeSnagRemark.add(signInController.getSnagDataClosedList!.data![i].closeSnagRemark);
       dueDates.add(signInController.getSnagDataClosedList!.data![i].dueDate);
       createdDates.add(signInController.getSnagDataClosedList!.data![i].createdAt);
       snagData.add(signInController.getSnagDataClosedList!.data![i]);
       dateDifference.add(DateTime.parse(signInController.getSnagDataClosedList!.data![i].dueDate!).difference(DateTime.parse(signInController.getSnagDataClosedList!.data![i].createdAt!)).inDays);
      }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 110),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subLocationName.length,
              itemBuilder: (BuildContext context, int index) {
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
                                child: Center(
                                  child: CircleAvatar(
                                  backgroundColor: dateDifference[index]<0?Colors.red:dateDifference[index]==0?Colors.green:const Color.fromRGBO(255, 192, 0, 1),
                                  radius: 15.0,
                                  child: Text(dateDifference[index].toString(),style:const TextStyle(color: Colors.black),),
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
                            height: 70,
                            width: 330,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                            child:
                            InkWell(
                              onTap: (){
                                context.pushNamed('SNAGDETAIL',
                                // queryParams: {"from": "openedDeSnag"},
                                extra: snagData[index]);
                              },
                              child:
                              Column(children: [
                              const  SizedBox(height: 10,),
                             Row(children: [
                              Text("Snag Remark: ",style: textStyleHeadline4,),
                              Text((remark[index]!=null? (remark[index]!.length>30?"${remark[index]!.substring(0,29)}...":remark[index] ?? ""):""),style: textStyleBodyText2,overflow: TextOverflow.ellipsis,),
                             ],),
                              Row(children: [
                              Text("De-Snag Remark: ",style: textStyleHeadline4,),
                              Text((deSnagRemark[index]!=null? (deSnagRemark[index]!.length>30?"${deSnagRemark[index]!.substring(0,29)}...":deSnagRemark[index] ?? ""):""),style: textStyleBodyText2,overflow: TextOverflow.ellipsis,),
                              ]),
                             Row(children: [
                              Text("Closing Remark: ",style: textStyleHeadline4,),
                               Text((closingDeSnagRemark[index]!=null?(closingDeSnagRemark[index]!.length>30?"${closingDeSnagRemark[index]!.substring(0,29)}...":closingDeSnagRemark[index] ?? ""):""),style: textStyleBodyText2,overflow: TextOverflow.ellipsis,)
                             ],)
                            ]),
                            ),
                            ),
                            ]
                          )
                        );
                    }
                  )
        ),
      ],
    )),
   );
      }
      );
  }
}
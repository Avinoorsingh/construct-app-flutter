import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/signInController.dart';
import '../network/client_project.dart';

// ignore: must_be_immutable
class ProjectLevelPage1 extends StatefulWidget {
  ProjectLevelPage1({Key? key,required this.clientData}) : super(key: key);
  dynamic clientData;

  @override
  State<ProjectLevelPage1> createState() => _ProjectLevelPage1State();
}

class _ProjectLevelPage1State extends State<ProjectLevelPage1> {
   final getClientProjectsController = Get.find<GetClientProject>();
    final getClientProfileController = Get.find<GetUserProfileNetwork>();
  final List<ChartData> chartData = [   
            ChartData('David', 60,"60.0\n Balance %",Colors.green,),
            ChartData('Steve', 40,"40.0\n Work \nDone %",const Color.fromRGBO(255, 192, 0, 1)),
            // ChartData('Jack', 34, const Color.fromRGBO(228,0,124,1)),
            // ChartData('Others', 52, const Color.fromRGBO(255,189,57,1))
        ];
    List<String> items = [
    "assets/images/labour_data_img.png",
    "assets/images/activites.png",
    "assets/images/quality_checklist_img.png",
    "assets/images/snag_desnag_img.png",
    "assets/images/other_360.png",
    "assets/images/other_360.png",
    "assets/images/other_360.png",
  ];
  List<String> ButtonText = [
    "LABOUR DATA",
    "ACTIVITIES",
    "QUALITY CHECKLIST",
    "SNAG",
    "360 IMAGE",
    "AREAS OF CONCERN",
    "DRAWING MASTER",
  ];
   List<String> iconText = [];
 late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    getClientProfileController.getUserProfile(context: context);
    getClientProjectsController.getSelectedProjects(context: context);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<String> myToolsData=[];
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      print("I am here!!");
      print(signInController.getProjectData?.snagCount);
     EasyLoading.dismiss();
    return
    signInController.getProjectData?.clientid!=null?
    ListView(
      children:[
      Center(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: 7,
            itemBuilder: (ctx, i) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), //<-- SEE HERE
              ),
            child: Container(
            height: 290,
            width: 350,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50)),
            margin: const EdgeInsets.all(5),
            //padding: const EdgeInsets.all(5),
            child: Stack(
                  children: [
                  Column(
                  children: [
                        Container(
                          height: 90,
                          width: 100,
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(items[i].toString(),
                        fit: BoxFit.fill,
                        ),
                        ),
                        if(i!=3)...{
                        Center(child: 
                        Container(
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                        child:
                        Stack(children: [
                        Card(
                          margin: const EdgeInsets.all(8),
                          shadowColor: Colors.transparent,
                          color: Colors.white,
                          elevation: 10,
                          child: 
                        MaterialButton(onPressed: (){},
                        height: 45,
                        color: const Color.fromARGB(255, 29, 51, 88),
                        child: Center(child:Text(ButtonText[i],
                        textAlign: TextAlign.center,
                        style:textStyleButton.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          ),
                        )
                        )
                        ),
                        ),
                         Positioned(
                              top: 40,
                              left: 10,
                              right: 10,
                              // bottom: 20,
                              // left: 310,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child:  const Center(
                                  child: CircleAvatar(
                                    backgroundColor:Color.fromRGBO(255, 192, 0, 1),
                                    radius: 12.0,
                                    child: Text("0",style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                        ])
                        ),
                        ),
                        },
                         if(i==3)...{
                          FittedBox(child:
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[ 
                            GestureDetector(
                              onTap: (){
                                context.pushNamed('SNAGS');
                              },
                              child: 
                        Container(
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                        child:
                          Stack(children: [
                        Card(
                          margin: const EdgeInsets.all(8),
                          shadowColor: Colors.transparent,
                          color: Colors.white,
                          elevation: 10,
                          child: 
                        MaterialButton(onPressed: (){
                          context.pushNamed('SNAGS');
                        },
                        height: 45,
                        color: const Color.fromARGB(255, 29, 51, 88),
                        child: Center(child:Text(ButtonText[i],
                        textAlign: TextAlign.center,
                        style:textStyleButton.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          ),
                        )
                        )
                        ),
                        ),
                         Positioned(
                              top: 40,
                              left: 10,
                              right: 10,
                              // bottom: 20,
                              // left: 310,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child:  Center(
                                  child: CircleAvatar(
                                    backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
                                    radius: 12.0,
                                    child: Text( signInController.getProjectData!.snagCount.toString()!='null'?signInController.getProjectData!.snagCount.toString():"0",style: const TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ),
                            ),
                               GestureDetector(
                              onTap: (){
                                context.pushNamed('DESNAGS');
                              },
                              child: 
                         Container(
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                        child:
                         Stack(children: [
                        Card(
                          margin: const EdgeInsets.all(8),
                          shadowColor: Colors.transparent,
                          color: Colors.white,
                          elevation: 10,
                          child: 
                        MaterialButton(onPressed: (){
                            context.pushNamed('DESNAGS');
                        },
                        height: 45,
                        color: const Color.fromARGB(255, 29, 51, 88),
                        child: Center(child:Text("DESNAG",
                        textAlign: TextAlign.center,
                        style:textStyleButton.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          ),
                        )
                        )
                        ),
                        ),
                          Positioned(
                              top: 40,
                              left: 10,
                              right: 10,
                              // bottom: 20,
                              // left: 310,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child:  const Center(
                                  child: CircleAvatar(
                                    backgroundColor:Color.fromRGBO(255, 192, 0, 1),
                                    radius: 12.0,
                                    child: Text("0",style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                         ]
                         )
                        ),
                               ),
                        ]
                        ),
                          )
                        },
                  ],
                ),
              ],
            ),
          ),
        );
      },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
              ),
            ),
               const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: 
                        Card(
                           shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), //<-- SEE HERE
                        ),
                          elevation: 3,
                          child: 
                        Column(children: [
                          const SizedBox(height: 10,),
                          Center(child: Text("WORK SUMMERY",style: textStyleBodyText1.copyWith(fontWeight: FontWeight.bold),),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Row(children: const [Icon(Icons.square,color: Colors.green,size: 10), Text(" Work Done %    ",style: TextStyle(fontSize: 10),)],),
                              Row(children: const [Icon(Icons.square,color: Color.fromRGBO(255, 192, 0, 1),size: 10), Text(" Balance %    ",style: TextStyle(fontSize: 10),)],)
                            ],)
                          ],),
                          Stack(
                            alignment: Alignment.center,
                            children:[
                            Column(
                            children: [Text("Colab",style: textStyleBodyText1,),
                             const Text("Tools",style: TextStyle(color: Colors.grey),),
                            ]),
                        SfCircularChart(
                           series: <CircularSeries>[
                            // Renders doughnut chart
                            DoughnutSeries<ChartData, String>(
                                explode: true,
                                explodeAll: true,
                                explodeOffset: "0.9",
                                dataSource: chartData,
                                innerRadius: "65",
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelMapper: (ChartData data, _) => data.z,
                                dataLabelSettings: const DataLabelSettings(
                                    // Renders the data label
                                    textStyle: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                    isVisible: true
                                )
                            )
                        ]
                    ),
                        ]),
                    ]),)
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: 
                        Card(
                           shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                          elevation: 3,
                          child: 
                        Column(children: [
                          const SizedBox(height: 10,),
                          Center(child: Text("WORK TREND",style: textStyleBodyText1.copyWith(fontWeight: FontWeight.bold),),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [],)
                          ],),
                          Stack(children:[
                        SfCartesianChart(
                          legend: Legend(isVisible: true,position: LegendPosition.bottom),
                          zoomPanBehavior: ZoomPanBehavior(  
                            enablePanning: true,
                            zoomMode: ZoomMode.xy,
                            enablePinching: true,
                          enableMouseWheelZooming: true,
                          enableSelectionZooming: true
                        ),  
                        primaryXAxis: DateTimeAxis(
                          enableAutoIntervalOnZooming: true,
                          isVisible: true,opposedPosition: true,
                        dateFormat: DateFormat.y()),
                        primaryYAxis: NumericAxis(
                          decimalPlaces: 2,enableAutoIntervalOnZooming: true),
                        series: <ChartSeries>[
                    StackedColumn100Series<ExpenseData, DateTime>(
                        color:  const Color.fromRGBO(255, 192, 0, 1),
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.mother,
                        name: 'PRW',
                        // dataLabelMapper: (ExpenseData exp, _) => exp.father.toString(),
                        // markerSettings: const MarkerSettings(
                        //   isVisible: true,
                        // ),
                         dataLabelSettings: const DataLabelSettings(        
                        isVisible: true, alignment: ChartAlignment.near),
                        ),
                    StackedColumn100Series<ExpenseData, DateTime>(
                        color: Colors.green,
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.son,
                        name: 'IN HOUSE',
                        // dataLabelMapper: (ExpenseData exp, _) => exp.father.toString(),
                        // markerSettings: const MarkerSettings(
                        //   isVisible: true,
                        // ),
                        dataLabelSettings: const DataLabelSettings(        
                        isVisible: true, alignment: ChartAlignment.near)),
                    StackedColumn100Series<ExpenseData, DateTime>(
                      color: const Color.fromARGB(255, 45, 90, 158),
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.daughter,
                        name: 'MISC',
                        // dataLabelMapper: (ExpenseData exp, _) => exp.father.toString(),
                        // markerSettings: const MarkerSettings(
                        //   isVisible: true,
                        // ),
                        dataLabelSettings: const DataLabelSettings(        
                        isVisible: true, alignment: ChartAlignment.near)),
                          LineSeries<ExpenseData, DateTime>(
                            color: Colors.red,
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.father,
                        name: 'BCWP',
                        //  dataLabelMapper: (ExpenseData exp, _) => exp.father.toString(),
                        markerSettings: const MarkerSettings(
                          color: Colors.red,
                          isVisible: true,
                        ),
                        dataLabelSettings: const DataLabelSettings(        
                        isVisible: true,textStyle: TextStyle(color:Colors.red,))),
                        ]
                    )
                        ]),
                    ]),)
                )
      ]
      ): Container();
    });
  }
}


 class ChartData {
        ChartData(this.x, this.y, this.z,this.color);
            final String x;
            final double y;
            final String z;
            final Color color;
    }
    List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData(DateTime(0, 0), 0,0,0,0),
      ExpenseData(DateTime(0, 0), 0,0,0,0),
      ExpenseData(DateTime(0, 0), 0,0,0,0),
      ExpenseData(DateTime(0, 0), 0,0,0,0),
      ExpenseData(DateTime(0, 0), 0,0,0,0),
    ];
    return chartData;
  }

class ExpenseData {
  ExpenseData(
      this.expenseCategory, this.father, this.mother, this.son, this.daughter);
  final num father;
  final DateTime expenseCategory;
  final num mother;
  final num son;
  final num daughter;
}
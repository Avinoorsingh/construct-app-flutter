import 'dart:convert';
import 'package:colab/models/category_list.dart';
import 'package:colab/models/clientEmployee.dart';
import 'package:colab/models/client_response.dart';
import 'package:colab/models/location_list.dart';
import 'package:colab/models/login_response_model.dart';
import 'package:colab/models/login_user.dart';
import 'package:colab/models/snag_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';

class GetClientProject extends GetxController {
  List<ClientProfileData> getClientProjects= [];
  bool isLoading = true;
  var clientProjects = <ClientProfileData>[];
  ClientProfileData? getSingleProjectData;

  Future getUpcomingProjects(
      {
      required BuildContext context,
     }) async {
    try {
      //  EasyLoading.show(maskType: EasyLoadingMaskType.black);
      isLoading = true;
      var getUserDataUrl=Uri.parse(Config.getUserDataApi);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var tokenValue=sharedPreferences.getString('token');
          var clientId=sharedPreferences.getString('client_id');
          var id=sharedPreferences.getString('id'); 
      update();
      var res=await http.get(
            getUserDataUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $tokenValue",
              'client_id':clientId.toString(),
              'id':id.toString(),
            }
            );

           Map<String, dynamic> resSuccess=jsonDecode(jsonEncode(res.body));
           if(resSuccess['data'].length>1){
             for(var data in  resSuccess['data']){
            clientProjects.add(ClientProfileData.fromJson(data));
           }
      if(getClientProjects.isEmpty){
      getClientProjects = clientProjects.toSet().toList();
      }
      isLoading = false;
      update();
           }
    } catch (e) {
      // EasyLoading.dismiss();
      isLoading = false;
      update();
      print('getClientData nhi chali !!');
      print(e);
    }
  }


   Future getSelectedProjects(
      {
      selectedDate,
      required BuildContext context,
     }) async {
    try {
      //  EasyLoading.show(maskType: EasyLoadingMaskType.black);
      isLoading = true;
      var getUserDataUrl=Uri.parse(Config.getSelectedProjectApi+selectedDate);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          var tokenValue=sharedPreferences.getString('token');
          var clientId=sharedPreferences.getString('client_id');
          var id=sharedPreferences.getString('id'); 
      update();
      var res=await http.get(
            getUserDataUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $tokenValue",
              'client_id':clientId!,
              'id':id!,
            }
            );

           Map<String, dynamic> resSuccess=jsonDecode(res.body);
           if(resSuccess['data'].length>1){
             for(var data in  resSuccess['data']){
            clientProjects.add(ClientProfileData.fromJson(data));
           }
      if(getClientProjects.isEmpty){
      getClientProjects = clientProjects.toSet().toList();
      }
      isLoading = false;
      update();
           }
            else if(resSuccess['data'].length<=1){
              print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
                   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                   sharedPreferences.setString("projectIdd",resSuccess['data'][0]['project_id'].toString());
               var result= ClientProfileData.fromJson(resSuccess['data']);
               getSingleProjectData=result;
            }
    } catch (e) {
      // EasyLoading.dismiss();
      isLoading = false;
      update();
      print('getProject data nhi chali !!');
      print(e);
    }
  }
}



class GetUserProfileNetwork extends GetxController{
  final signInController = Get.find<SignInController>();
  final getClientProjectsController = Get.find<GetClientProject>();
  static var client=http.Client();
  Future getUserProfile({token, required BuildContext context}) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var email=sharedPreferences.getString('userName');
     var password=sharedPreferences.getString('password');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
     LoginUserModel model= LoginUserModel(userId: email, password: password);
     print("token::::"'$email+$password');
   Map<String, String> requestHeaders={
      'Content-Type':'application/json',
      "Accept": "application/json",
      "Authorization": "Bearer""$token}",
    };
    try {
      //  EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var url=Uri.parse(Config.loginApi);
    update();
    var response=await client.post(
    url, 
    headers: requestHeaders,
    body: jsonEncode(model.toJson())
    );
    print("Client level");
    Map<String,dynamic>  cData= jsonDecode(response.body);
    LoginResponseModel result = LoginResponseModel.fromJson(cData['data']);
    signInController.getClientProfile = result;
    ClientProfileData result1=ClientProfileData.fromJson(cData['data']);
    signInController.getProjectData=result1;
    await getClientProjectsController.getSelectedProjects(context: context,selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var projectID=sharedPreferences.getString('projectIdd');
    print("I am here fvfwdwwcwew");
    print(projectID);
    if(signInController.getProjectData?.clientid!=null || projectID!=null){
       var getCategoryListUrl=Uri.parse("${Config.getCategoryListApi}${signInController.getProjectData!.clientid}/${signInController.getProjectData!.projectid??"1"}");
       var res=await http.get(
            getCategoryListUrl,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            }
          );
          Map<String,dynamic> cData2=jsonDecode(res.body);
          CategoryList result2=CategoryList.fromJson(cData2['data']);
          signInController.getCategoryList=result2;
    }
    try {
     var getLocationListUrl=Uri.parse(Config.locationListApi);
        var res=await http.post(
            getLocationListUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
              "client_id":signInController.getProjectData?.clientid.toString(),
              "project_id":projectID,
            }
            );
            print('here');
            print(res.body);
          Map<String,dynamic> cData3=jsonDecode(res.body);
          LocationList result3=LocationList.fromJson(cData3['data']);
          signInController.getLocationList=result3;    
            } catch (e) {
              print("error in getting location list");
              print(e);
              print("error in getting location list");
            }
    try {
     var getEmployeesUrl=Uri.parse("${Config.getEmployees}$projectID");
        var res=await http.get(
            getEmployeesUrl,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          ClientEmployee result4=ClientEmployee.fromJson(cData4['data']);
          signInController.getEmployeeList=result4;  
          print(":::::???????????????:::");
          print(result4);
          // print(cData4['data'][0]['user_id']);  
            } catch (e) {
              print("error in getting employee list");
              print(e);
            }
     update();
    } catch (e) {
      if (kDebugMode) {
        print('error in fetching user profile data!!!');
        print(e);
      }
       update();
    }
  }
}

class GetNewSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getSnagData({token, required BuildContext context}) async {
    final getClientProjectsController = Get.find<GetClientProject>();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var email=sharedPreferences.getString('userName');
     var password=sharedPreferences.getString('password');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getSnagsUrl=Uri.parse("${Config.getSnagByStatusApi}$clientID/${projectID??"1"}/N/$isClient");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getSnagDataList=result5; 
            } catch (e) {
              if (kDebugMode) {
                print("error in getting new snag list");
                print(e);
              }
            }
  }
}

class GetOpenedSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getOpenedSnagData({token, required BuildContext context}) async {
     final getClientProjectsController = Get.find<GetClientProject>();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var email=sharedPreferences.getString('userName');
     var password=sharedPreferences.getString('password');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getSnagsUrl=Uri.parse("${Config.getSnagByStatusApi}$clientID/${projectID??"1"}/O/$isClient");
      print("}}}}}}}}}}}{{");
      print(projectID);
      print(isClient);
      print(clientID);
       print("}}}}}}}}}}}{{");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getSnagDataOpenedList=result5;  
          print("getting opened snag data"); 
            } catch (e) {
              if (kDebugMode) {
                print("error in opened snag list");
                print(e);
              }
            }
  }
}

class GetClosedSnag extends GetxController{
  final signInController = Get.find<SignInController>();
  static var client=http.Client();
  Future getClosedSnagData({token, required BuildContext context}) async {
     final getClientProjectsController = Get.find<GetClientProject>();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var email=sharedPreferences.getString('userName');
     var password=sharedPreferences.getString('password');
     bool? isClientSignedIn=sharedPreferences.getBool('isClientSignedIn');
     await getClientProjectsController.getSelectedProjects(context: context,selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
     var isClient=false;
     if(isClientSignedIn==true){
      isClient=true;
     }
      bool? isProjectSignedIn=sharedPreferences.getBool('isProjectSignedIn');
      if(isProjectSignedIn==true){
        isClient=false;
      }
      try {
      var getSnagsUrl=Uri.parse("${Config.getSnagByStatusApi}$clientID/${projectID??"1"}/C/$isClient");
        var res=await http.get(
            getSnagsUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          );
          Map<String,dynamic> cData4=jsonDecode(res.body);
          SnagData result5=SnagData.fromJson(cData4['data']);
          signInController.getSnagDataClosedList=result5;  
            } catch (e) {
              if (kDebugMode) {
                print("error in getting closed snag list");
                print(e);
              }
            }
  }
}
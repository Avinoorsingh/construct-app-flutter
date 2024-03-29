import 'package:colab/network/area_of_concern_network.dart';
import 'package:colab/network/client_project.dart';
import 'package:colab/network/labourData/labour_data_network.dart';
import 'package:colab/network/onGoingSiteProgress/ongoing_site_network.dart';
import 'package:colab/network/progress_network.dart';
import 'package:colab/network/quality_network.dart';
import 'package:get/get.dart';
import '../../controller/signInController.dart';

class DependencyInjector {
  static final signInController = Get.put(SignInController());
  static final getClientController=Get.put(GetClientProject());
  static final getUserProfileNetwork=Get.put(GetUserProfileNetwork());
  static final getSnagData=Get.put(GetNewSnag());
  static final getLabourDataContractorList=Get.put(GetLabourDataContractor());
  static final getLabourDataofSelectContractor=Get.put(GetSelectedContractorData());
  static final getLabourDataToday=Get.put(GetLabourDataToday());
  static final getDeSnagData=Get.put(GetNewDeSnag());
  static final getNewQualityCheckData=Get.put(GetNewCheckList());
  static final getCompletedSiteProgress=Get.put(GetCompletedSiteProgress());
  static final getOnGoingOnGoingData=Get.put(GetOnGoingDetail());
  static final getOnGoingCompletedData=Get.put(GetOnGoingCompletedDetail());
  static final getOnGoingUpcomingData=Get.put(GetOnUpComingData());
  static final getOnGoingSiteProgress=Get.put(GetOnGoingSiteProgress());
  static final getInEqualitySiteProgress=Get.put(GetInEqualitySiteProgress());
  static final getAreaOfConcernData=Get.put(GetAreaOfConcern());
  static final getOpenedSnagData=Get.put(GetOpenedSnag());
  static final getOpenedDeSnagData=Get.put(GetOpenedDeSnag());
  static final getOpenedQualityCheckData=Get.put(GetOpenedCheckList());
  static final getClosedSnagData=Get.put(GetClosedSnag());
  static final getClosedDeSnagData=Get.put(GetClosedDeSnag());
  static final getClosedQualityCheckData=Get.put(GetClosedCheckList());
  static final getSnagCount=Get.put(GetSnagsCount());
  static final getProgressCount=Get.put(GetProgressCount());

  static void initializeControllers() {
    Get.put(SignInController());
    Get.put(GetClientProject());
    Get.put(GetUserProfileNetwork());
    Get.put(GetNewSnag());
    Get.put(GetNewDeSnag());
    Get.put(GetNewCheckList());
    Get.put(GetOpenedSnag());
    Get.put(GetOpenedDeSnag());
    Get.put(GetOpenedCheckList());
    Get.put(GetClosedSnag());
    Get.put(GetClosedDeSnag());
    Get.put(GetClosedCheckList());
    Get.put(GetAreaOfConcern());
    Get.put(GetCompletedSiteProgress());
    Get.put(GetOnGoingSiteProgress());
    Get.put(GetInEqualitySiteProgress());
    Get.put(GetOnGoingDetail());
    Get.put(GetOnUpComingData());
    Get.put(GetOnGoingCompletedDetail());
    Get.put(GetLabourDataContractor());
    Get.put(GetLabourDataToday());
    Get.put(GetSelectedContractorData());
    Get.put(GetSnagsCount());
    Get.put(GetProgressCount());
  }

   static void deleteControllers() {
    Get.deleteAll();
  }
}
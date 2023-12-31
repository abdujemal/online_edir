import 'package:get/get.dart';

import '../../../../Model/my_info.dart';

class MainController extends GetxController {
  Rx<MyInfo> myInfo = MyInfo(
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ).obs;

  var edirList = [].obs;

  RxBool userInfoIsAvailable = false.obs;

  void setUserInfoIsAvailable(bool val) {
    userInfoIsAvailable.value = val;
  }

  void setMyInfo(MyInfo val) {
    myInfo.value = val;
  }
}

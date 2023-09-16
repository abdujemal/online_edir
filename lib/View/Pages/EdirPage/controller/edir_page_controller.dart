import 'package:get/get.dart';
import 'package:online_edir/Model/edir.dart';

class EdirPAgeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxBool isTokenLoading = false.obs;

  RxString accessToken = "".obs;

  Rx<Edir> currentEdir = Edir("", "", "", "", "", "", "", "", "", "").obs;

  void setIsTokenLoading(bool val) {
    
    isTokenLoading.value = val;
  }

  void setAccessToken(String token) {
    accessToken.value = token;
  }

  void setCurrentEdir(Edir val) {
    currentEdir.value = val;
  }

  void setSelectedIndex(int val) {
    selectedIndex.value = val;
  }
}

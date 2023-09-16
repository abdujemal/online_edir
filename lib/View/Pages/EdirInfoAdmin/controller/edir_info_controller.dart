import 'package:get/get.dart';
import 'package:online_edir/Model/bankaccount_options.dart';

class EdirInfoController extends GetxController {
  var options = [].obs;
  RxBool isLoading = false.obs;

  void setIsLoading(bool val) {
    isLoading.value = val;
  }

  void addList(BankAccountOption val) {
    options.add(val);
  }

  void clearData() {
    options.clear();
  }

  bool isEmpty() {
    return options.isEmpty;
  }
}

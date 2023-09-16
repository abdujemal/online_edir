import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/CreateEdir/create_edir_page.dart';
import '../Pages/JoinEdir/join_edir_page.dart';
import '../Pages/MainPage/controller/main_controller.dart';
import 'big_btn.dart';
import 'msg_snack.dart';

class JCEdir extends StatelessWidget {
  JCEdir({Key? key}) : super(key: key);

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigBtn(
              text: "Create Edir".tr,
              icon: Icons.add,
              action: () =>
              mainController.userInfoIsAvailable.value?
                Get.to(() => const CreateEdirPage()): MSGSnack(title: "Alert!", msg: "Loading", color: Colors.white).show()
              ),
          const SizedBox(
            height: 100,
          ),
          BigBtn(
              text: "Join Edir".tr,
              icon: Icons.join_inner,
              action: () =>
              mainController.userInfoIsAvailable.value?
                Get.to(() => const JoinEdirPage()): MSGSnack(title: "Alert!", msg: "Loading", color: Colors.white).show()
              )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/EdirPage/edir_page.dart';
import '../Pages/MainPage/controller/main_controller.dart';
import 'edir_member_item.dart';

class EdirListWidget extends StatefulWidget {
  const EdirListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EdirListWidget> createState() => _EdirListWidgetState();
}

class _EdirListWidgetState extends State<EdirListWidget> {
  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>ListView.builder(
        itemCount: mainController.edirList.length,
        itemBuilder: (context, index) => EdirMemberItem(
          imgUrl: mainController.edirList[index].img_url,
          title: mainController.edirList[index].edirName,
          subtitle:
              "Created by".tr+mainController.edirList[index].created_by_name+"creat".tr,
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (c) =>
                        EdirPage(edirId: mainController.edirList[index].eid)),
                (route) => false);
          },
        ),
      ),
    );
  }
}

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_edir/View/Pages/EdirPage/tabs/announcement_page.dart';
import 'package:online_edir/View/Pages/EdirPage/tabs/store_page.dart';

import '../../../Controller/user_service.dart';
import '../../../constants.dart';
import '../../Widgets/bottom_bar.dart';
import '../../Widgets/edir_drawer.dart';
import '../MainPage/controller/main_controller.dart';
import 'controller/edir_page_controller.dart';
import 'tabs/meeting_page.dart';

class EdirPage extends StatefulWidget {
  String edirId;
  EdirPage({Key? key, required this.edirId}) : super(key: key);

  @override
  State<EdirPage> createState() => _EdirPageState();
}

class _EdirPageState extends State<EdirPage> {
  var _key = GlobalKey<ScaffoldState>();

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: const Icon(
          Icons.announcement,
        ),
        label: "Announcement".tr),
    BottomNavigationBarItem(
        icon: const Icon(
          Icons.store,
        ),
        label: "Store".tr),
    BottomNavigationBarItem(
        icon: const Icon(Icons.video_call), label: "Meeting".tr)
  ];

  List<Widget> pages = [
    const AnnouncementPage(),
    const StorePage(),
    const MeetingPage()
  ];

  UserService userService = Get.put(UserService());

  MainController mainController = Get.put(MainController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userService.getEdirList();

    userService.getEdir(widget.edirId);

    // FirebaseMessaging.instance
    //     .subscribeToTopic(mainController.myInfo.value.uid);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserService()).getUserInfo();
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        drawer: const EdirDrawer(),
        bottomNavigationBar: BottomBar(items: items),
        appBar: AppBar(
          title: Obx(() => edirPAgeController.currentEdir.value.edirName != ""
              ? Text(edirPAgeController.currentEdir.value.edirName)
              : Text("Loading...".tr)),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Image.asset(
                "assets/dots.png",
                color: Colors.white,
                width: 25,
              ),
            )
          ],
        ),
        body: Obx(() => pages[edirPAgeController.selectedIndex.value]),
      ),
    );
  }
}

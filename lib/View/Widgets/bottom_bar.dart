import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../Pages/EdirPage/controller/edir_page_controller.dart';

class BottomBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  const BottomBar({Key? key, required this.items}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>BottomNavigationBar(
        backgroundColor: secondColor,
          onTap: (v) {
            edirPAgeController.setSelectedIndex(v);
          },
          currentIndex: edirPAgeController.selectedIndex.value,
          items: widget.items),
    );
  }
}

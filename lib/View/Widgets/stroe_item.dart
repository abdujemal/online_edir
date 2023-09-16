import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/user_service.dart';
import '../../Model/store.dart';
import '../../constants.dart';
import '../Pages/EdirPage/controller/edir_page_controller.dart';
import '../Pages/MainPage/controller/main_controller.dart';
import '../Pages/StoreDetail/store_detail.dart';

class StoreItem extends StatelessWidget {
  Store store;
  StoreItem({Key? key, required this.store}) : super(key: key);

  UserService userService = Get.put(UserService());
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());
  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => StoreDetail(store: store)),
      child: Ink(
        decoration: BoxDecoration(
            color: mainColor,
            border: Border(bottom: BorderSide(color: secondColor))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.network(
                  store.img_url,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Text(
                        store.itemName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(width: 200, child: Text(store.itemDescription)),
                    ],
                  ),
                )
              ]),
              edirPAgeController.currentEdir.value.created_by !=
                      mainController.myInfo.value.uid
                  ? const SizedBox()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              userService.editStore(
                                  "increament",
                                  "Store/${edirPAgeController.currentEdir.value.eid}/${store.sid}",
                                  store.quantity,
                                  store.img_url);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 40,
                            )),
                        Text(
                          store.quantity,
                          style: const TextStyle(fontSize: 22),
                        ),
                        IconButton(
                            onPressed: () {
                              userService.editStore(
                                  "decreament",
                                  "Store/${edirPAgeController.currentEdir.value.eid}/${store.sid}",
                                  store.quantity,
                                  store.img_url);
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 40,
                            ))
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    store.dateTime,
                    style: const TextStyle(fontSize: 13),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

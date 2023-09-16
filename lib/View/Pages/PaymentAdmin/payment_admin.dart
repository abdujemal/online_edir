import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/edir_member.dart';
import '../../../constants.dart';
import '../../Widgets/common_btn.dart';
import '../../Widgets/edir_member_fr_payment.dart';
import '../EdirPage/controller/edir_page_controller.dart';
import '../MainPage/controller/main_controller.dart';
import '../PaymentRequestForm/payment_request_form.dart';
import '../PaymentRequestPageAdmin/payment_request_page_admin.dart';

class PaymentAdmin extends StatefulWidget {
  const PaymentAdmin({Key? key}) : super(key: key);

  @override
  State<PaymentAdmin> createState() => _PaymentAdminState();
}

class _PaymentAdminState extends State<PaymentAdmin> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child("EdirMembers");

  List<EdirMember>? memberList;

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: CommonBtn(
            text: "Send To All".tr,
            action: () {
              if(memberList != null){

              Get.to(() => PaymentRequestForm(members: memberList!));
              }
            }),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:
              Text("${edirPAgeController.currentEdir.value.edirName} Members"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: databaseReference
                .child(edirPAgeController.currentEdir.value.eid)
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                memberList = [];
                Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                    (snapshot.data as DatabaseEvent).snapshot.value as Map);

                for (Map<dynamic, dynamic> memberData in data.values) {
                  EdirMember edirMember =
                      EdirMember.fromFirebaseMap(memberData);
                  if (edirMember.uid != null) {
                    if (edirMember.uid != mainController.myInfo.value.uid) {
                      memberList!.add(edirMember);
                    }
                  }
                }
              }
              return memberList == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : memberList!.isEmpty
                      ? Center(child: Text("No Members".tr))
                      : ListView.builder(
                          itemCount: memberList!.length,
                          itemBuilder: ((context, index) => EdirMemberFrPayment(
                              img_url: memberList![index].img_url,
                              name: memberList![index].userName,
                              position: memberList![index].position,
                              onTap: () => Get.to(()=>PaymentRequestPageAdmin(
                                    edirMember: memberList![index],
                                  )))));
            }),
      ),
    );
  }
}

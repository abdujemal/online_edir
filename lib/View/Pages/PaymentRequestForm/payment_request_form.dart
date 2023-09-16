import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/user_service.dart';
import '../../../Model/edir_member.dart';
import '../../../constants.dart';
import '../../Widgets/common_btn.dart';
import '../../Widgets/common_input.dart';
import '../EdirPage/controller/edir_page_controller.dart';
import '../PaymentAdmin/payment_admin.dart';
import '../PaymentRequestPageAdmin/payment_request_page_admin.dart';
import 'controller/payment_request_form_controller.dart';

class PaymentRequestForm extends StatefulWidget {
  List<EdirMember> members;
  PaymentRequestForm({Key? key, required this.members}) : super(key: key);

  @override
  State<PaymentRequestForm> createState() => _PaymentRequestFormState();
}

class _PaymentRequestFormState extends State<PaymentRequestForm> {
  GlobalKey<FormState> _key = GlobalKey();

  var titleTc = TextEditingController();

  var descriptionTc = TextEditingController();

  UserService userService = Get.put(UserService());

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  PaymentRequestFormController paymentRequestFormController =
      Get.put(PaymentRequestFormController());

  sendRequest() async {
    paymentRequestFormController.setIsLoading(true);
    for (EdirMember edirMember in widget.members) {
      await userService.sendPaymentRequest(
          edirMember.uid,
          "NotPayed",
          titleTc.text,
          descriptionTc.text,
          edirPAgeController.currentEdir.value.eid);
    }
    paymentRequestFormController.setIsLoading(false);
    titleTc.text = "";
    descriptionTc.text = "";
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (c) => widget.members.length > 1
                ? const PaymentAdmin()
                : PaymentRequestPageAdmin(edirMember: widget.members[0])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Payment Request Form".tr),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                    controller: titleTc,
                    hint: "Request Messege".tr,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                    controller: descriptionTc,
                    hint: "Amount Of Money".tr,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => paymentRequestFormController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CommonBtn(text: "Send".tr, action: () => sendRequest()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}



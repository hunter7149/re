import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/app/api/service/prefrences.dart';

import '../../../components/common_widgets.dart';
import '../controllers/restriction_controller.dart';

class RestrictionView extends GetView<RestrictionController> {
  const RestrictionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String message = Pref.readData(key: Pref.RESTRICTION_MESSAGE) ??
        'Please contact IT department!';
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: ZoomTapAnimation(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Icon(
      //       Icons.arrow_back,
      //       color: Colors.grey.shade700,
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: Center(child: COMMONWIDGET.restriction(message: message)),
    );
  }
}

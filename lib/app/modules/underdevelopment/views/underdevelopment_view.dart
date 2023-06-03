import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/common_widgets.dart';
import '../controllers/underdevelopment_controller.dart';

class UnderdevelopmentView extends GetView<UnderdevelopmentController> {
  const UnderdevelopmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      body: Center(child: COMMONWIDGET.underDev()),
    );
  }
}

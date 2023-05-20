import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';

import '../controllers/services_controller.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: COMMONWIDGET.underDev()),
    );
  }
}

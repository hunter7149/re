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
      backgroundColor: Colors.white,
      body: Center(child: COMMONWIDGET.restriction(message: message)),
    );
  }
}

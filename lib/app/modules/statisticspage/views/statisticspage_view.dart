import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';

import '../../../../constants.dart';
import '../controllers/statisticspage_controller.dart';

class StatisticspageView extends GetView<StatisticspageController> {
  const StatisticspageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: COMMONWIDGET.globalAppBar(
          tittle: "Statistics",
          backFunction: () {
            Get.back(
              id: Constants.nestedNavigationNavigatorId,
            );
          }),
      body: Center(
        child: Text(
          'StatisticspageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/statisticspage_controller.dart';

class StatisticspageView extends GetView<StatisticspageController> {
  const StatisticspageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatisticspageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StatisticspageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/leadershippage_controller.dart';

class LeadershippageView extends GetView<LeadershippageController> {
  const LeadershippageView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeadershippageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LeadershippageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

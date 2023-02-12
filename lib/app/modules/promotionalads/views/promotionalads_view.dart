import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/promotionalads_controller.dart';

class PromotionaladsView extends GetView<PromotionaladsController> {
  const PromotionaladsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PromotionaladsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PromotionaladsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

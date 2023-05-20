import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/offerinfo_controller.dart';

class OfferinfoView extends GetView<OfferinfoController> {
  const OfferinfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfferinfoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OfferinfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

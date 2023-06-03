
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // controller.saveDeviceInfo();
    controller.navigate();
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/logo/remark.png',
                  height: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Image.asset(
                  'assets/logo/login_logo_hb.png',
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

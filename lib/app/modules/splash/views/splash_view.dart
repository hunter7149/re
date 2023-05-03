import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sales/app/routes/app_pages.dart';
import '../../../config/app_assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // controller.saveDeviceInfo();
    Timer(Duration(seconds: 2), () {
      Get.offNamed(Routes.LOGIN);
    });
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

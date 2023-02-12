import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../config/app_assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.navigate();
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 126, 221, 255),
              Color.fromARGB(255, 88, 64, 226),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AppAssets.ASSET_APP_REMARK_LOGO,
              height: 80,
            ),
            const SizedBox(height: 10),
            const Text(
              'E-Commerce',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  textAlign: TextAlign.center,
                  'You can buy anything from here!',
                  textStyle:
                      const TextStyle(fontSize: 16.0, color: Colors.white),
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 2,
              pause: const Duration(milliseconds: 200),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            )
          ],
        ),
      )),
    );
  }
}

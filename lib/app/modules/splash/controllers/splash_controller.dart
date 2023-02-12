import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  navigate() {
    Timer(const Duration(milliseconds: 2000), () {
      // final status = GetStorage().read('login_status') ?? false;
      // if (status) {
      //   Get.offNamed(Routes.HOME);
      // } else {
      //   Get.offNamed(Routes.LOGIN);
      // }
      Get.offNamed(Routes.LOGIN);
    });
  }
}

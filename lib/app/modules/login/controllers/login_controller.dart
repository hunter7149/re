import 'package:flutter/widgets.dart';

import '../../../routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool obsecure = false.obs;
  obsecureUpdater() {
    obsecure.value = !obsecure.value;
  }

  onTapLogin() {
    Get.toNamed(Routes.INDEX);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

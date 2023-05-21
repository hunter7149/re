import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../../api/service/prefrences.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  RxString device_id = 'Unknown'.obs;
  Future<void> saveDeviceInfo() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    device_id.value = deviceId ?? "n/a";
    update();

    Pref.writeData(key: Pref.DEVICE_IDENTITY, value: device_id.value);

    print(
        "Device id-------------------------------------${Pref.readData(key: Pref.DEVICE_IDENTITY)}");
  }

  navigate() async {
    await saveDeviceInfo();
    String token = await Pref.readData(key: Pref.LOGIN_INFORMATION) ?? "";
    if (token.isNotEmpty) {
      bool restrictionstatus =
          Pref.readData(key: Pref.RESTRICTION_STATUS) ?? false;
      if (restrictionstatus) {
        Get.toNamed(Routes.RESTRICTION);
      } else {
        Timer(Duration(milliseconds: 2000), () {
          Get.offNamed(Routes.INDEX);
        });
      }
    } else {
      Timer(Duration(milliseconds: 2000), () {
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
}

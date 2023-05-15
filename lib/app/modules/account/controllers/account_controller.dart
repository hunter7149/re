import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/routes/app_pages.dart';

class AccountController extends GetxController {
  logOut() async {
    await GetStorage().remove(Pref.LOGIN_INFORMATION).then((value) async {
      await GetStorage().remove(Pref.USER_ID);
      await GetStorage().remove(Pref.USER_PASSWORD);
      await GetStorage().remove(Pref.FCM_TOKEN);
      Get.offNamed(Routes.LOGIN);
    });
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

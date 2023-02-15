import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:red_tail/app/components/app_strings.dart';
import 'package:red_tail/app/components/internet_connection_checker.dart';

import '../../../api/repository/repository.dart';
import '../../../routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String apimsg = AppStrings.apiData;
  RxBool obsecure = false.obs;
  obsecureUpdater() {
    obsecure.value = !obsecure.value;
  }
  //-------------------------------Login function--------------------------------//

  RxBool isRequest = false.obs;
  requestLogin() async {
    if (email.text.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar("Notice", "Please enter your email or phone number",
          snackStyle: SnackStyle.GROUNDED,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 5,
          colorText: Colors.white,
          duration: Duration(seconds: 2));
      // ShowToast.toastInCenter(message: "Enter user email");
    } else if (password.text.isEmpty) {
      Get.closeAllSnackbars();
      // ShowToast.toastInCenter(message: "Enter user password");
      Get.snackbar("Notice", "Please enter your password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 5,
          colorText: Colors.white,
          duration: Duration(seconds: 2));
    } else {
      if (ICHECKER.checkConnection() == true) {
        isRequest.value = true;
        update();
        Map<String, dynamic> loginMap = {
          "email": email.text.toString(),
          "password": password.text.toString(),
        };
        try {
          await Repository().requestLogin(map: loginMap).then((value) {
            print("${apimsg} -> $value");
            isRequest.value = false;
            update();
          });
        } on Exception catch (e) {
          isRequest.value = false;
          update();
          if (kDebugMode) {
            print("error -> $e");
          }
        }
      } else {
        Get.generalDialog(
            transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4 * anim1.value,
                    sigmaY: 4 * anim1.value,
                  ),
                  child: FadeTransition(
                    child: child,
                    opacity: anim1,
                  ),
                ),
            pageBuilder: (ctx, anim1, anim2) => MediaQuery(
                  data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "No Internet!",
                          style: TextStyle(),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Center(
                                child: Icon(
                              Icons.close,
                              color: Colors.red.shade800,
                              size: 20,
                            )),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        )
                      ],
                    ),
                    content: Container(
                      child: Text(
                        "Please check your internet connection!",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    actionsPadding: EdgeInsets.all(10),
                    actions: [
                      Obx(() => isRequest.value
                          ? Container(
                              // padding: EdgeInsets.all(10),
                              child: Center(
                              child: CircularProgressIndicator(),
                            ))
                          : InkWell(
                              onTap: () {
                                Get.back();
                                requestLogin();
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade500,
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.center,
                                child: Text("Retry",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ))
                    ],
                  ),
                ));
      }
    }
  }

  onTapLogin() {
    GetStorage storage = GetStorage("sync-data");
    storage.write("lastSyncTime", "${DateTime.now()}");
    String value = storage.read("lastSyncTime");
    print("Saved last sync date = ${value}");

    Get.toNamed(Routes.INDEX);
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    String value = GetStorage().read("lastSyncTime") ?? "0";
    print("Saved last sync date = ${value}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

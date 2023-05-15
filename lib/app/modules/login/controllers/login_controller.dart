import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/components/app_strings.dart';
import 'package:sales/app/components/internet_connection_checker.dart';

import '../../../api/repository/repository.dart';
import '../../../api/service/prefrences.dart';
import '../../../components/connection_checker.dart';
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

  RxBool isLogingIn = false.obs;
  dynamic data;

  requestLogin() async {
    if (email.text.isEmpty) {
      Get.snackbar("Warning", "Username is empty!",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    } else if (password.text.isEmpty) {
      Get.snackbar("Warning", "Password is empty!",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      if (await IEchecker.checker()) {
        isLogingIn.value = true;
        update();

        try {
          await Repository().requestLogin(map: {
            "username": email.text,
            "password": password.text
          }).then((value) async {
            print(value);
            dynamic data = value["value"] ?? {};
            if (data != {}) {
              // Pref.writeData(key: Pref.USER_PROFILE, value: data);
            }
            if (value["result"] == "success" && value["accessToken"] != "") {
              Pref.writeData(
                  key: Pref.LOGIN_INFORMATION, value: value['accessToken']);
              Pref.writeData(key: Pref.USER_ID, value: email.text);
              Pref.writeData(key: Pref.USER_PASSWORD, value: password.text);
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              CollectionReference stringsCollection =
                  firestore.collection('fcm_token');
              try {
                await stringsCollection.doc("${email.text}").set({
                  'device': Pref.readData(key: Pref.DEVICE_IDENTITY).toString(),
                  'token': Pref.readData(key: Pref.FCM_TOKEN).toString(),
                  'userId': "${email.text}"
                });
                print('String uploaded successfully');
              } catch (e) {
                print('Error uploading string: $e');
              }
              // try {
              //   await stringsCollection.add({
              //     'device': Pref.readData(key: Pref.DEVICE_IDENTITY).toString(),
              //     'token': Pref.readData(key: Pref.FCM_TOKEN).toString(),
              //     'userId': "${email.text}"
              //   });
              //   print('String uploaded successfully');
              // } catch (e) {
              //   print('Error uploading string: $e');
              // }
              isLogingIn.value = false;
              update();
              Get.offNamed(Routes.INDEX);
            } else {
              isLogingIn.value = false;
              update();
              Get.snackbar("Failed", "${value['result'] ?? "Try again"}",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM);
            }
          });
        } on Exception catch (e) {
          isLogingIn.value = false;
          update();
          Get.snackbar("SERVER ERROR", "TRY AGAIN LATER",
              colorText: Colors.white,
              borderRadius: 2,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade500,
              duration: Duration(seconds: 2));
        }
      } else {
        Get.snackbar("NO INTERNET", "PLEASE ENABLE INTERNET",
            colorText: Colors.white,
            borderRadius: 2,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade500,
            duration: Duration(seconds: 2));
      }
    }
    isLogingIn.value = false;
    update();
    // onTapLogin();
  }

  onTapLogin() {
    GetStorage storage = GetStorage("sync-data");
    storage.write("lastSyncTime", "${DateTime.now()}");
    String value = storage.read("lastSyncTime");
    print("Saved last sync date = ${value}");

    Get.offNamed(Routes.INDEX);
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

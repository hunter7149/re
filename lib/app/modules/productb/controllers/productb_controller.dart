import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/repository/repository.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/components/connection_checker.dart';
import 'package:sales/app/config/app_themes.dart';

class ProductbController extends GetxController {
  final count = 0.0.obs;
  RxList<dynamic> products = <dynamic>[].obs;
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  dataSetter(dynamic es) {
    data.value = es as Map<String, dynamic>;
    Update();
    print(data);
    requestItemCount();
  }

  RxBool isItemCountLoading = false.obs;

  requestItemCount() async {
    isItemCountLoading.value = true;
    Update();
    if (await IEchecker.checker()) {
      try {
        await Repository().getBrandItemCount(
            body: {"brand": data['brand']}).then((value) async {
          if (value == null) {
            offlineProductsModule();
            isItemCountLoading.value = false;

            Update();
          } else {
            products.clear();
            products.value = value['value'] ?? [];
            products.refresh();
            // Pref.writeData(key: data['brand'], value: products.value);
            isItemCountLoading.value = false;

            Update();
          }
        });
      } on Exception catch (e) {
        offlineProductsModule();
        isItemCountLoading.value = false;
        Update();
        Get.snackbar("Server error", "Data loaded in offline mode!",
            backgroundColor: AppThemes.modernSexyRed,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            duration: Duration(seconds: 4));
      }
    } else {
      offlineProductsModule();
      Get.snackbar("No internet", "Data loaded in offline mode!",
          backgroundColor: AppThemes.modernSexyRed,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          duration: Duration(seconds: 4));
    }
  }

  offlineProductsModule() async {
    dynamic offline = Pref.readData(key: 'offlineData');
    Map<String, List<dynamic>> offline2 = offline['${data['brand']}'] ?? {};
    List<String> offline2Keys = offline2.keys.toList();
    products.clear();
    for (int i = 0; i < offline2.length; i++) {
      products.add({
        "GENERIC_NAME": offline2Keys[i],
        "TTL": offline2[offline2Keys[i]]?.length
      });
      products.refresh();
    }
    // print(offline.runtimeType);
    // print(offline['nior'].length);

    // products.value = offline['${data['brand']}'] ?? [];
    // products.refresh();
    isItemCountLoading.value = false;
    Update();
  }

  @override
  void onInit() {
    super.onInit();
    // dataSetter(data);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

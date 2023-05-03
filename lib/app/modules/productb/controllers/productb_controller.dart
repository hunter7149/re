import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/repository/repository.dart';
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
            await GetStorage().write(data['brand'], products.value);
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
    products.value = await GetStorage().read('${data['brand']}') ?? [];
    products.refresh();
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

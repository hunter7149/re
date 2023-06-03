import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/repository/repository.dart';
import '../../components/connection_checker.dart';
import '../../config/app_themes.dart';
import 'package:sales/app/api/service/prefrences.dart' as a;

class OFFLINEPRODUCTSYNC {
  offlineDataSync({required dynamic brands}) async {
    RxBool isSyncing = false.obs;
    RxBool stepOne = false.obs;
    RxBool stepTwo = false.obs;

    if (await IEchecker.checker()) {
      isSyncing.value = true;
      Update();
      // Get.snackbar('SYNC', 'PRODUCT SYNCING STATUS: ${isSyncing.value}',
      //     colorText: Colors.white,
      //     backgroundColor: AppThemes.modernBlue,
      //     borderRadius: 0,
      //     animationDuration: Duration(seconds: 0),
      //     duration: Duration(seconds: 2));
      Map<String, Map<String, List<dynamic>>> ProductData = {};
// Iterate over the BrandList
      for (var brand in brands) {
        // Check if the brand exists in the nested dictionary, otherwise add it
        if (!ProductData.containsKey(brand)) {
          ProductData[brand] = {};
        }

        // Fetch the categories for the current brand
        try {
          await Repository()
              .getBrandItemCount(body: {"brand": brand}).then((value) async {
            if (value != null &&
                value['value'] != null &&
                value['value'].isNotEmpty) {
              List<dynamic> categories = value['value'];

              stepOne.value = true;
              Update();
              // Iterate over the categories
              for (var category in categories) {
                if (category['GENERIC_NAME'] != null) {
                  String genericName = category['GENERIC_NAME'] ?? 'NO NAME';

                  // Check if the generic name exists for the brand, otherwise add it
                  if (!ProductData[brand]!.containsKey(genericName)) {
                    ProductData[brand]![genericName] = [];
                  }

                  // Fetch the products for the current brand and generic name
                  try {
                    await Repository().getAllProducts(body: {
                      "brand": brand,
                      "generic_name": genericName.toLowerCase()
                    }).then((value) {
                      if (value != null &&
                          value['value'] != null &&
                          value['value'].isNotEmpty) {
                        List<dynamic> products = value['value'];

                        // Add the products to the corresponding brand and generic name
                        ProductData[brand]![genericName]!.addAll(products);
                        isSyncing.value = false;

                        stepTwo.value = true;
                        Update();
                      } else {
                        isSyncing.value = false;
                        stepTwo.value = false;
                        Update();
                      }
                    });
                  } on Exception {
                    isSyncing.value = false;
                    Update();
                  }
                }
              }
            } else {
              isSyncing.value = false;
              Update();
            }
          });
        } on Exception {
          isSyncing.value = false;
          Update();
        }
      }
      if (stepOne.value == true &&
          stepTwo.value == true &&
          isSyncing.value == false) {
        print(ProductData);
        await GetStorage.init("remark_sales_app_data");
        a.Pref.writeData(key: a.Pref.OFFLINE_DATA, value: ProductData);
        a.Pref.writeData(
            key: 'offlineDataSyncDate', value: DateTime.now().toString());
        Get.closeCurrentSnackbar();
        Get.snackbar('SYNC COMPLETE', 'OFFLINE PRODUCTS UPDATED',
            colorText: Colors.white,
            backgroundColor: AppThemes.modernGreen,
            animationDuration: Duration(seconds: 0),
            borderRadius: 0,
            duration: Duration(seconds: 2));
        print("Sync successful");
      } else {
        print("Sync unsuccessful");
      }
    }
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/repository/repository.dart';
import 'package:sales/app/api/service/prefrences.dart';

import '../../../routes/app_pages.dart';

class ProductController extends GetxController {
  RxList<dynamic> mainProductList = <dynamic>[].obs;

  RxList<dynamic> categories = <dynamic>[].obs;
  RxList<dynamic> prdct = <dynamic>[].obs;

  RxList<String> brands = [
    'acnol',
    'blazoskin',
    'elanvenezia',
    'tylox',
    'herlan',
    'lily',
    'nior',
    'orix',
    'siodil',
    'sunbit',
  ].obs;
  OfflineProductSetter1({required List<String> bandList}) async {
    List<String> BrandList = bandList ?? [];
    if (BrandList.isNotEmpty) {
      for (int i = 0; i < BrandList.length; i++) {
        print(BrandList[i]);
        await Future.delayed(Duration(seconds: 1)).then((value) async {
          await Repository().getBrandItemCount(
              body: {"brand": BrandList[i]}).then((value) async {
            if (value != null && value['value'] != []) {
              categories.clear();
              categories.value = value['value'] ?? [];
              categories.refresh();
              categories.forEach((element) async {
                await Future.delayed(Duration(seconds: 1)).then((value) async {
                  await OfflineProductSetter2(
                      brand: BrandList[i], generic: element['GENERIC_NAME']);
                });
              });
            }
          });
        });
      }
    }
  }

  // requestGeneric({required String brand}) async {
  //   await Repository()
  //       .getBrandItemCount(body: {"brand": brand}).then((value) async {
  //     if (value != null && value['value'] != []) {
  //       categories.clear();
  //       categories.value = value['value'] ?? [];
  //       categories.refresh();

  //       // await Future.delayed(Duration(seconds: 1));
  //     }
  //   });
  // }

  // printData() async {
  //   brands.forEach((element) async {
  //     dynamic storedData = await GetStorage().read(element);
  //     if (storedData != null) {
  //       print("Data for $element: $storedData");
  //     } else {
  //       print("No data found for $element");
  //     }
  //   });
  // }

  OfflineProductSetter2(
      {required String brand, required String generic}) async {
    await Repository().getAllProducts(body: {
      "brand": brand,
      "generic_name": generic.toLowerCase()
    }).then((value) async {
      if (value != null) {
        prdct.clear();
        prdct.value = value["value"] ?? [];
        prdct.refresh();
        dynamic data = {"${generic}": prdct};
        mainProductList.add({"${brand}": data});
        print(
            "---------------------------------------${brand}-------------------------------------${generic}");
        print(mainProductList.value);

        print(
            "-------------------------------------------------------------------------------------------");
        // await GetStorage().write("${brand}-${generic}", prdct.value);
      }
    });
  }

  testfunction() async {
    Map<String, Map<String, List<dynamic>>> nestedDict = {};
// Iterate over the BrandList
    for (var brand in brands) {
      // Check if the brand exists in the nested dictionary, otherwise add it
      if (!nestedDict.containsKey(brand)) {
        nestedDict[brand] = {};
      }

      // Fetch the categories for the current brand
      await Repository()
          .getBrandItemCount(body: {"brand": brand}).then((value) async {
        if (value != null &&
            value['value'] != null &&
            value['value'].isNotEmpty) {
          List<dynamic> categories = value['value'];

          // Iterate over the categories
          for (var category in categories) {
            String genericName = category['GENERIC_NAME'];

            // Check if the generic name exists for the brand, otherwise add it
            if (!nestedDict[brand]!.containsKey(genericName)) {
              nestedDict[brand]![genericName] = [];
            }

            // Fetch the products for the current brand and generic name
            await Repository().getAllProducts(body: {
              "brand": brand,
              "generic_name": genericName.toLowerCase()
            }).then((value) {
              if (value != null &&
                  value['value'] != null &&
                  value['value'].isNotEmpty) {
                List<dynamic> products = value['value'];

                // Add the products to the corresponding brand and generic name
                nestedDict[brand]![genericName]!.addAll(products);
              }
            });
          }
        }
      });
    }
    print(nestedDict);
    Pref.writeData(key: "offlineData", value: nestedDict);
  }

  loadData() async {
    brands.value = [
      'acnol',
      'blazoskin',
      'elanvenezia',
      'tylox',
      'herlan',
      'lily',
      'nior',
      'orix',
      'siodil',
      'sunbit',
    ];
    brands.refresh();
    // await OfflineProductSetter1(bandList: brands.value);
    testfunction();
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

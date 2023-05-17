import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/repository/repository.dart';

import '../../../routes/app_pages.dart';

class ProductController extends GetxController {
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
        await Future.delayed(Duration(seconds: 5)).then((value) async {
          await Repository().getBrandItemCount(
              body: {"brand": BrandList[i]}).then((value) async {
            if (value != null && value['value'] != []) {
              categories.clear();
              categories.value = value['value'] ?? [];
              categories.refresh();

              await GetStorage().write('${BrandList[i]}', value['value']);
              GetStorage().save();
              // await Future.delayed(Duration(seconds: 1));
            }
          });
        });
      }
      // BrandList.forEach((brand) async {

      // });

      // printData();
    }
  }

  requestGeneric({required String brand}) async {
    await Repository()
        .getBrandItemCount(body: {"brand": brand}).then((value) async {
      if (value != null && value['value'] != []) {
        categories.clear();
        categories.value = value['value'] ?? [];
        categories.refresh();

        // await Future.delayed(Duration(seconds: 1));
      }
    });
  }

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
    await Repository().getAllProducts(
        body: {"brand": brand, "generic_name": generic}).then((value) async {
      if (value != null) {
        prdct.clear();
        prdct.value = value["value"] ?? [];
        prdct.refresh();
        await GetStorage().write("${brand}-${generic}", prdct.value);
      }
    });
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
    await OfflineProductSetter1(bandList: brands.value);
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

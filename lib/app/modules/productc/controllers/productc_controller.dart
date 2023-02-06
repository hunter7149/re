import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProductcController extends GetxController {
  // dynamic argumentData = Get.arguments;
  // @override
  // void onInit() {
  //   print(argumentData[0]['first']);
  //   print(argumentData[1]['second']);
  //   super.onInit();
  // }
  //RxInt currentIndex = 4.obs;
// onTapMain(){
//   Get.toNamed(Routes.INDEX);
// }
  final count = 0.0.obs;
  RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  initializeProducts() {
    products.value = [
      {
        "productId": 101,
        "name": "Tylox",
        "weight": "300 ml",
        "offer": "BOGO",
        "description": "This is a demo product",
        "ingredients": "Menthol, Soap",
        "claims": "non-alergic, adove 18",
        "catagory": "Toilet Cleaner",
        "unit": "pcs",
        "price": 99.5,
        "brand": "Remark",
        "quantity": 5,
        "img":
            "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
        "video": ""
      },
      {
        "productId": 102,
        "name": "Nior",
        "weight": "500 ml",
        "offer": "15% off",
        "description": "This is a demo product",
        "ingredients": "Serum,Vitamin C",
        "claims": "non-alergic,adove 18",
        "catagory": "Toilet Cleaner",
        "unit": "pcs",
        "price": 99.5,
        "brand": "Remark",
        "quantity": 5,
        "img":
            "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
        "video": ""
      }
    ];
    products.refresh();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initializeProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void setArgument(String argument) {
    print('setArgument');
  }
}

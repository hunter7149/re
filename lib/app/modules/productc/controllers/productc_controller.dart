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
  void setArgument(String argument){
    print('setArgument');
  }
}

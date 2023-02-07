// import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../routes/app_pages.dart';

class ProductcController extends GetxController {
  // late VideoPlayerController videoPlayerController;

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

  // videoInit() async {
  //   videoPlayerController = VideoPlayerController.network('');
  //   await videoPlayerController.initialize();
  //   videoPlayerController.play();
  //   isVideoInitalized.value = true;
  //   update();
  // }
  RxString VideoUrl = "".obs;
  RxBool isVideoInitalized = false.obs;
  seeVideo({required String link}) async {
    VideoUrl.value = link;
    update();
    VideoPlayerController videoPlayerController;
    videoPlayerController = VideoPlayerController.network(VideoUrl.value);
    await videoPlayerController.initialize();
    videoPlayerController.play();
    isVideoInitalized.value = true;
    update();
    return Container(
      height: 250,
      color: Colors.red,
      child: VideoPlayer(videoPlayerController),
    );
  }

  testpo({required String a}) {
    print("-------------------------------------");
    print(a);
  }

  final count = 0.0.obs;
  RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  initializeProducts() async {
    products.value = [
      {
        "productId": 101,
        "name": "Tylox",
        "weight": "300 ml",
        "offer": "BOGO",
        "description": "This is a demo product",
        "ingredients": ["Menthol", "Soap"],
        "claims": ["non-alergic", "adove 18"],
        "catagory": "Toilet Cleaner",
        "unit": "pcs",
        "price": 99.5,
        "brand": "Remark",
        "quantity": 5,
        "img":
            "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
        "video":
            "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4"
      },
      {
        "productId": 102,
        "name": "Nior",
        "weight": "500 ml",
        "offer": "15% off",
        "description": "This is a demo product",
        "ingredients": ["Serum", "Vitamin C"],
        "claims": ["non-alergic", "adove 18"],
        "catagory": "Toilet Cleaner",
        "unit": "pcs",
        "price": 99.5,
        "brand": "Remark",
        "quantity": 5,
        "img":
            "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
        "video":
            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
      }
    ];
    products.refresh();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initializeProducts();
    // videoInit();
    // videoController();
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

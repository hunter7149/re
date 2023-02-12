// import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_tail/app/components/cart_value.dart';
import 'package:red_tail/app/models/cartproduct.dart';
import 'package:red_tail/app/modules/index/controllers/index_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../DAO/cartitemdao.dart';
import '../../../database/database.dart';
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

  addToCart({required CartItem data}) async {
    CartItem item = data;
    if (await cartItemDao.insertCartItem(data).then((value) => true)) {
      totalpriceUpdater();
      CartCounter.cartCounter();
      Get.snackbar(
        "Success",
        "Product added successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      totalpriceUpdater();
      Get.snackbar(
        "Success",
        "Product was not added!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    ;

    // final data = await cartItemDao.findAllCartItem() as List<CartItem>;
    print("=======================");
    // print(data);
    // isReorder.value = true;
    // update();

    // Timer(Duration(seconds: 2), () {
    //   isReorderCompleted.value = true;
    // update();
    // });
  }

  late CartItemDao cartItemDao;

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
  }

  totalpriceUpdater() {
    totalPrice.value = 0.0;
    update();
  }

  RxDouble totalPrice = 0.0.obs;
  calculation({required double price, required int quanity}) {
    totalPrice.value = price * quanity;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initializeProducts();
    initValues();
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

// import 'package:chewie/chewie.dart';
import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:red_tail/app/api/repository/repository.dart';
import 'package:red_tail/app/components/cart_value.dart';
import 'package:red_tail/app/components/internet_connection_checker.dart';
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
//   Get.toNamed(Routes.INDEX);a
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

  RxInt count = 1.obs;
  countUpdateR({required int value}) {
    count.value = value;
    update();
  }

  RxList<dynamic> products = <dynamic>[].obs;
  initializeProducts() async {
    print("${tempData['brand']}");
    print("${tempData['type']}");
    await Repository().getAllProducts(body: {
      "brand": "${tempData['brand']}",
      "generic_name": "${tempData['type']}".toLowerCase()
    }).then((value) {
      products.value = value["value"];
      products.refresh();
      update();
    });
    // products.value = [
    //   {
    //     "productId": 101,
    //     "name": "Tylox",
    //     "weight": "300 ml",
    //     "offer": "BOGO",
    //     "description": "This is a demo product",
    //     "ingredients": ["Menthol", "Soap"],
    //     "claims": ["non-alergic", "adove 18"],
    //     "catagory": "Toilet Cleaner",
    //     "unit": "pcs",
    //     "price": 99.5,
    //     "brand": "Remark",
    //     "quantity": 5,
    //     "img":
    //         "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
    //     "video":
    //         "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
    //   },
    //   {
    //     "productId": 102,
    //     "name": "Nior",
    //     "weight": "500 ml",
    //     "offer": "15% off",
    //     "description": "This is a demo product",
    //     "ingredients": ["Serum", "Vitamin C"],
    //     "claims": ["non-alergic", "adove 18"],
    //     "catagory": "Toilet Cleaner",
    //     "unit": "pcs",
    //     "price": 99.5,
    //     "brand": "Remark",
    //     "quantity": 5,
    //     "img":
    //         "https://www.rizik.com.bd/wp-content/uploads/Nior-Matte-Lipstick-Pencil-18.jpg",
    //     "video": "http://techslides.com/demos/sample-videos/small.mp4"
    //   },
    //   {
    //     "productId": 102,
    //     "name": "Nior",
    //     "weight": "500 ml",
    //     "offer": "15% off",
    //     "description": "This is a demo product",
    //     "ingredients": ["Serum", "Vitamin C"],
    //     "claims": ["non-alergic", "adove 18"],
    //     "catagory": "Toilet Cleaner",
    //     "unit": "pcs",
    //     "price": 99.5,
    //     "brand": "Remark",
    //     "quantity": 5,
    //     "img":
    //         "https://www.rizik.com.bd/wp-content/uploads/Nior-Matte-Lipstick-Pencil-18.jpg",
    //     "video": "http://techslides.com/demos/sample-videos/small.mp4"
    //   },
    //   {
    //     "productId": 102,
    //     "name": "Nior",
    //     "weight": "500 ml",
    //     "offer": "15% off",
    //     "description": "This is a demo product",
    //     "ingredients": ["Serum", "Vitamin C"],
    //     "claims": ["non-alergic", "adove 18"],
    //     "catagory": "Toilet Cleaner",
    //     "unit": "pcs",
    //     "price": 99.5,
    //     "brand": "Remark",
    //     "quantity": 5,
    //     "img":
    //         "https://www.rizik.com.bd/wp-content/uploads/Nior-Matte-Lipstick-Pencil-18.jpg",
    //     "video": "http://techslides.com/demos/sample-videos/small.mp4"
    //   }
    // ];
    products.refresh();
    update();
  }

  addToCart({required CartItem data}) async {
    if (await ICHECKER.checkConnection()) {
      print("INTERNET");
    } else {
      print("NO INTERNET");
    }

    // Check if the item already exists in the cart
    CartItem? existingItem =
        await cartItemDao.findCartItemById(data.productId!).first;

    if (existingItem != null && data != null) {
      // If the item already exists, update its quantity
      CartItem temporaryItem = existingItem;

      existingItem.quantity = (existingItem.quantity! + data.quantity!);
      existingItem.price = (existingItem.price! + data.price!);

      if (await cartItemDao
          .updateCartItem(existingItem)
          .then((value) => true)) {
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
          "Failure",
          "Product quantity was not updated!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // If the item does not exist, insert it into the cart
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
          "Failure",
          "Product was not added!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
  // addToCart({required CartItem data}) async {
  //   if (await ICHECKER.checkConnection()) {
  //     print("INTERNET");
  //   } else {
  //     print("NO INTERNET");
  //   }
  //   CartItem item = data;
  //   if (await cartItemDao.insertCartItem(data).then((value) => true)) {
  //     totalpriceUpdater();
  //     CartCounter.cartCounter();
  //     Get.snackbar(
  //       "Success",
  //       "Product added successfully!",
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   } else {
  //     totalpriceUpdater();
  //     Get.snackbar(
  //       "Failure",
  //       "Product was not added!",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  //   ;

  //   // final data = await cartItemDao.findAllCartItem() as List<CartItem>;
  //   print("=======================");
  //   // print(data);
  //   // isReorder.value = true;
  //   // update();

  //   // Timer(Duration(seconds: 2), () {
  //   //   isReorderCompleted.value = true;
  //   // update();
  //   // });
  // }

  late CartItemDao cartItemDao;

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    // requestItemCount();
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

  RxList<Map<int, dynamic>> videoControllerList = <Map<int, dynamic>>[].obs;
  assignVideoController() {
    products.forEach((element) {
      if (element["video"] != null && element["video"].toString().isNotEmpty) {
        VideoPlayerController videoPlayerController =
            VideoPlayerController.network(element["video"]);
        Map<int, dynamic> tempData = {
          element["productId"]: videoPlayerController
        };
        videoControllerList.add(tempData);
        videoControllerList.refresh();
      }
    });
  }

  singleController({required int productId}) {
    // search for the element with productId in videoControllerList
    final videoControllerMap = videoControllerList.firstWhereOrNull(
      (element) => element.containsKey(productId),
    );

    // if the videoControllerMap is not null, return the video URL
    if (videoControllerMap != null) {
      print(videoControllerMap[productId].runtimeType);
      return videoControllerMap[productId];
    } else {
      return null;
    }
  }

  returnPlayer({required int productId}) {
    VideoPlayerController videoPlayerController =
        singleController(productId: productId);
    if (videoPlayerController != null) {
      ChewieController chewieController = new ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          autoInitialize: true,
          showOptions: false,
          showControls: true,
          aspectRatio: 1.5);

      videoPlayerController.initialize();
      return Chewie(
        controller: chewieController,
      );
    } else {
      return Container();
    }
  }

  void disposeVideoControllers() {
    for (final videoControllerMap in videoControllerList) {
      final videoPlayerController = videoControllerMap.values.first;
      videoPlayerController.dispose();
    }
    videoControllerList.clear();
  }

//-----------------------------------------------------------------Online data------------------------------------------------------------//
  RxMap<String, dynamic> tempData = <String, dynamic>{}.obs;
  setData({required dynamic data}) async {
    tempData.value = data as Map<String, dynamic>;
    tempData.refresh();
    update();
    await initializeProducts();
  }

  RxBool isItemCountLoading = false.obs;
  requestItemCount() async {
    isItemCountLoading.value = true;
    update();
    await Repository().getAllProducts(body: {'brand': 'nior'}).then((value) {
      products.clear();
      products.value = value['value'];
      products.refresh();
      isItemCountLoading.value = false;

      update();
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // initializeProducts();
    initValues();
    await assignVideoController();

    // videoInit();
    // videoController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    disposeVideoControllers();
  }

  void setArgument(String argument) {
    print('setArgument');
  }
}

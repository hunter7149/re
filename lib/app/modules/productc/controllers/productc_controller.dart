// import 'package:chewie/chewie.dart';
import 'dart:async';
import 'dart:ui';

import 'package:chewie/chewie.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/repository/repository.dart';
import 'package:sales/app/components/cart_value.dart';
import 'package:sales/app/components/connection_checker.dart';
import 'package:sales/app/components/internet_connection_checker.dart';
import 'package:sales/app/models/cartproduct.dart';
import 'package:sales/app/modules/index/controllers/index_controller.dart';

import 'package:video_player/video_player.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../DAO/cartitemdao.dart';
import '../../../config/app_themes.dart';
import '../../../database/database.dart';
import '../../../routes/app_pages.dart';

class ProductcController extends GetxController {
  List<Color> randomeColor = [
    AppThemes.modernBlue,
    AppThemes.modernGreen,
    AppThemes.modernPurple,
    AppThemes.modernRed,
    AppThemes.modernCoolPink
  ];
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
  RxBool isProductLoading = false.obs;

  initializeProducts() async {
    print("${tempData['brand']}");
    print("${tempData['type']}");
    isProductLoading.value = true;
    update();

    if (await IEchecker.checker()) {
      try {
        await Repository().getAllProducts(body: {
          "brand": "${tempData['brand']}",
          "generic_name": "${tempData['type']}".toLowerCase()
        }).then((value) async {
          products.value = value["value"] ?? [];
          products.refresh();
          await GetStorage().write(
              "${tempData['brand']}-${tempData['type']}", products.value);
          update();
        });
        isProductLoading.value = false;
        update();
      } on Exception catch (e) {
        offlineDataModule();
        Get.snackbar("Server error", "Data loaded in offline mode!",
            backgroundColor: AppThemes.modernSexyRed,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            borderRadius: 0,
            duration: Duration(seconds: 2));
        isProductLoading.value = false;
        update();
      }
    } else {
      offlineDataModule();
      Get.snackbar("No internet", "Data loaded in offline mode!",
          backgroundColor: AppThemes.modernSexyRed,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          borderRadius: 0,
          duration: Duration(seconds: 2));
      isProductLoading.value = false;
      update();
    }

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

  offlineDataModule() async {
    products.value =
        await GetStorage().read("${tempData['brand']}-${tempData['type']}") ??
            [];
    products.refresh();
    update();
  }

  RxBool isAdded = false.obs;
  isAddedUpdater() {
    isAdded.value = true;
    update();
    Timer(Duration(seconds: 1), () {
      isAdded.value = false;
      update();
    });
  }

  imageLinkReturn(
      {required String brand,
      required String category,
      required String productid}) {
    if (brand == 'lily' &&
        category.toLowerCase() == 'face care' &&
        productid.toString() == '3000077') {
      return "https://mir-s3-cdn-cf.behance.net/project_modules/fs/c77ab8168198481.6436822b7611f.jpg";
    } else if (brand == 'lily' &&
        category.toLowerCase() == 'face care' &&
        productid.toString() == '3000078') {
      return "https://mir-s3-cdn-cf.behance.net/project_modules/fs/30522e168198481.6436822b754e6.jpg";
    } else if (brand.toLowerCase() == 'lily' &&
        category.toLowerCase() == 'face care' &&
        productid.toString() == '3000079') {
      return "https://mir-s3-cdn-cf.behance.net/project_modules/fs/e689c3168198481.6436822b76b2b.jpg";
    } else if (brand.toLowerCase() == 'lily' &&
        category.toLowerCase() == 'face care' &&
        productid.toString() == '3000080') {
      return "https://mir-s3-cdn-cf.behance.net/project_modules/fs/e87ac8168198481.6436822b7320e.jpg";
    } else if (brand.toLowerCase() == 'lily' &&
        category.toLowerCase() == 'face care') {
      return "https://herlan.com/wp-content/uploads/2023/04/Lily-Banner-Image-1.png";
    } else if (brand.toLowerCase() == 'lily' &&
        category.toLowerCase() == 'colour Cosmetics') {
      return "https://herlan.com/wp-content/uploads/2023/04/Lily-Banner-Image-1.png";
    } else if (brand.toLowerCase() == 'herlan' &&
        category.toLowerCase() == 'colour cosmetics') {
      return "https://herlan.com/wp-content/uploads/2023/04/Harlan-Eye-Color32.png";
    } else if (brand.toLowerCase() == 'nior') {
      return "https://mir-s3-cdn-cf.behance.net/project_modules/fs/e87ac8168198481.6436822b7320e.jpg";
    } else {
      return "https://img.freepik.com/premium-vector/set-beauty-make-up-vector_744040-173.jpg";
    }
  }

  returnPrice({required String productCode}) {
    RxDouble price = 500.00.obs;
    if (productCode == '3000077') {
      price.value = 110.00;
      update();
    } else if (productCode == "3000078") {
      price.value = 110.00;
      update();
    } else if (productCode == "3000079") {
      price.value = 110.00;
      update();
    } else if (productCode == "3000080") {
      price.value = 110.00;
      update();
    } else if (productCode == "3000082") {
      price.value = 222.22;
      update();
    } else if (productCode == "3000083") {
      price.value = 222.22;
      update();
    } else if (productCode == "3000099") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000100") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000101") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000102") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000103") {
      price.value = 675.00;
      update();
    }

    return price.value;
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

        await isAddedUpdater();
        await successAlert();
        Timer(Duration(seconds: 1), () async {
          Get.back();
        });
        // Get.snackbar(
        //   "Success",
        //   "Product added successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
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
        isAddedUpdater();
        await successAlert();
        Timer(Duration(seconds: 1), () {
          Get.back();
        });
        // Get.snackbar(
        //   "Success",
        //   "Product added successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
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
    return totalPrice.value;
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

  successAlert() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.generalDialog(
          barrierDismissible: false,
          transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4 * anim1.value,
                  sigmaY: 4 * anim1.value,
                ),
                child: FadeTransition(
                  child: child,
                  opacity: anim1,
                ),
              ),
          pageBuilder: (ctx, anim1, anim2) {
            TextEditingController quanity = TextEditingController();

            return MediaQuery(
              data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Image.asset("assets/images/success.png")),
                          Text(
                            "Added to cart!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                actionsPadding: EdgeInsets.all(10),
                actions: [],
              ),
            );
          });
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

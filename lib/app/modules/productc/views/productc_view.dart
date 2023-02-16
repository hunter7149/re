import 'dart:ffi';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:red_tail/app/components/common_widgets.dart';
import 'package:red_tail/app/components/custom_image_catalog.dart';
import 'package:red_tail/app/components/custom_image_val.dart';
import 'package:red_tail/app/models/cartproduct.dart';
import 'package:video_player/video_player.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../components/bottom_navigation.dart';
import '../../../components/custom_image_field.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/productc_controller.dart';

class ProductcView extends GetView<ProductcController> {
  final String argument;
  const ProductcView({Key? key, required this.argument}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.setArgument(argument);
    //final  data=Get.arguments;
    //final String datat=data[0] as String;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: COMMONWIDGET.globalAppBar(
            tittle: "Description",
            backEnabled: true,
            backFunction: () {
              Get.back(
                id: Constants.nestedNavigationNavigatorId,
              );
            }),
        body: SafeArea(
            child: Obx(
          () => CarouselSlider(
            options: CarouselOptions(
                onScrolled: (value) {},
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1),
            items: controller.products.map((i) {
              List<String> ingredients = i["ingredients"];
              List<String> claims = i["claims"];

              return Builder(
                builder: (BuildContext context) {
                  VideoPlayerController videoPlayerController =
                      new VideoPlayerController.network(i["video"]);
                  ChewieController chewieController = new ChewieController(
                      videoPlayerController: videoPlayerController,
                      autoInitialize: true,
                      showOptions: false,
                      showControls: true,
                      aspectRatio: 1.5);
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //-----------------------------Product Image--------------------------------//
                            Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              // width: 125,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: "${i['img']}",
                                  // height: 160,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: SpinKitRotatingCircle(
                                    color: Colors.red,
                                    size: 50.0,
                                  )),
                                  errorWidget: (ctx, url, err) => Image.asset(
                                    'assets/images/noprev.png',
                                    height: 70,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${i['name']}',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Weight: ${i['weight']}',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Offers: ${i['offer']}',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Price: ${i['price']} Tk',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            COMMONWIDGET.addtoCart(
                                title: "Add to cart",
                                funtion: () {
                                  CartItem product = CartItem(
                                      userId: 1,
                                      productId: i["productId"],
                                      customerName: "",
                                      beatName: "",
                                      productName: i["name"],
                                      catagory: i["catagory"],
                                      unit: i["unit"],
                                      image: i["img"],
                                      price: i["price"],
                                      brand: i["brand"],
                                      quantity: 1);
                                  controller.addToCart(data: product);
                                  // addAlert(controller: controller, data: i);
                                },
                                color: Colors.green.shade300),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 16),
                            //   child: Column(
                            //     children: [
                            //       Container(
                            //         height: 250,
                            //         decoration: BoxDecoration(
                            //             borderRadius:
                            //                 BorderRadius.circular(15)),
                            //         child: VideoPlayer(videoPlayerController),
                            //       ),
                            //       ZoomTapAnimation(
                            //         onTap: () {
                            //           videoPlayerController.play();
                            //         },
                            //         child: Icon(
                            //           Icons.play_arrow,
                            //           size: 40,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // Obx(() => controller.isVideoInitalized.value
                            //     ? controller.seeVideo(link: i["video"])

                            //     //  Container(
                            //     //     height: 250,
                            //     //   )
                            //     //     color: Colors.red,
                            //     //     child: VideoPlayer(
                            //     //         controller.videoPlayerController),
                            //     : Container()),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'About ${i['name']}',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ' ${i['description']} ',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                height: 235,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7,
                                        color: Colors.grey.shade500),
                                    borderRadius: BorderRadius.circular(15)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Chewie(
                                    controller: chewieController,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Active Ingredients',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: ingredients
                                            .map((e) => Container(
                                                  margin: EdgeInsets.all(5),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .circleDot,
                                                        size: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        e,
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                      // Text(
                                      //   i['ingredients'],
                                      //   style: TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.w400),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Speical Claims',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: claims
                                            .map((e) => Container(
                                                  margin: EdgeInsets.all(5),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .circleDot,
                                                        size: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        e,
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                      // Text(
                                      //   i['claims'],
                                      //   style: TextStyle(
                                      //       fontSize: 20.0,
                                      //       fontWeight: FontWeight.w400),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                },
              );
            }).toList(),
          ),
        )));
  }

  static addAlert(
      {required ProductcController controller, required dynamic data}) {
    Get.generalDialog(
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
          quanity.text = 1.toString();

          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter Quantity:",
                    style: TextStyle(),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Icon(
                        Icons.close,
                        color: Colors.red.shade800,
                        size: 20,
                      )),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  )
                ],
              ),
              content: Container(
                height: 80,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ZoomTapAnimation(
                          onTap: () {
                            int a = int.tryParse(quanity.text) ?? 0;
                            if (a == 0) {
                            } else {
                              a--;
                            }

                            quanity.text = a.toString();
                            controller.calculation(
                                price: double.parse(data["price"].toString()),
                                quanity: a);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(5),
                            child: Center(
                                child: Icon(
                              FontAwesomeIcons.minus,
                              color: Colors.grey.shade800,
                              size: 15,
                            )),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 50,
                          child: TextField(
                            controller: quanity,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ZoomTapAnimation(
                          onTap: () {
                            int a = int.tryParse(quanity.text) ?? 0;
                            a++;
                            quanity.text = a.toString();
                            controller.calculation(
                                price: double.parse(data["price"].toString()),
                                quanity: a);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(5),
                            child: Center(
                                child: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.grey.shade800,
                              size: 15,
                            )),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total price: " +
                                  controller.totalPrice.value.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    if (int.parse(quanity.text) > 0) {
                      Get.back();
                      CartItem product = CartItem(
                          userId: 1,
                          productId: data["productId"],
                          customerName: "",
                          beatName: "",
                          productName: data["name"],
                          catagory: data["catagory"],
                          unit: data["unit"],
                          image: data["img"],
                          price: data["price"],
                          brand: data["brand"],
                          quantity: int.parse(quanity.text));
                      controller.addToCart(data: product);
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text("Add", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }
}

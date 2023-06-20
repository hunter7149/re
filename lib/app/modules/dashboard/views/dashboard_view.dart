import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/components/AppColors.dart';
import 'package:sales/app/components/app_strings.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/sync/products/offlineordersync.dart';
import 'package:sales/app/sync/products/offlineproductsync.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Obx(
        () => !controller.isInitalized.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initializing dashboard.Won't take long...",
                      style:
                          TextStyle(color: AppThemes.modernGreen, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Lottie.asset(
                      "assets/logo/loading.json",
                      height: 100,
                    )
                    // SpinKitPouringHourGlass(
                    //   size: 40,
                    //   color: AppThemes.modernGreen,
                    // )
                  ],
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 320,
                    pinned: false,
                    title: Text(
                      "Today's deal",
                      style: TextStyle(color: AppThemes.modernBlue),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      // titlePadding: EdgeInsets.all(16),
                      background: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Obx(
                          () => ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.urls.map((e) {
                              return ZoomTapAnimation(
                                onTap: () {
                                  offerDialogue(
                                      link: e['link'], type: e['type']);
                                },
                                child: Container(
                                  width: 200,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: offerItem(dataLink: e["thumb"]),
                                      ),
                                      if (e['type'] == 0)
                                        Container()
                                      else
                                        Center(
                                          child: Container(
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 80,
                                              color: AppThemes.modernGreen
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey.shade800),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount: _getCrossAxisCount(context),
                    childAspectRatio: 0.88,
                    children: [
                      menuItem(
                        icon: Icons.shopping_cart_checkout,
                        color: AppThemes.modernBlue,
                        valid: true,
                        title: "Order Management",
                        function: () {
                          Get.toNamed(
                            Routes.ORDERHOME,
                            id: Constants.nestedNavigationNavigatorId,
                          );
                        },
                      ),
                      menuItem(
                        icon: Icons.list,
                        color: AppThemes.modernPurple,
                        title: "Product Catalogue",
                        valid: true,
                        function: () async {
                          var result = await Get.toNamed(
                                Routes.PRODUCT,
                                arguments:
                                    controller.argumentToDetailPage.value,
                                id: Constants.nestedNavigationNavigatorId,
                              ) ??
                              1.0;
                          print(result);
                          double result2 = 1.0;
                          if (result != null) {
                            controller.argumentUpdater(result: result2);
                          }
                        },
                      ),
                      menuItem(
                        icon: Icons.notifications_active_rounded,
                        color: AppThemes.modernCoolPink,
                        title: "Notice",
                        valid: true,
                        function: () {
                          Get.toNamed(
                            Routes.NOTICESCREEN,
                            id: Constants.nestedNavigationNavigatorId,
                          );
                        },
                      ),
                      menuItem(
                        icon: Icons.sync,
                        color: AppThemes.modernGreen,
                        title: "Sync",
                        valid: true,
                        function: () async {
                          showDialog(
                            context: context,
                            barrierDismissible:
                                false, // Set barrier dismissible to false
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // title: Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "Syncing...",
                                //       style: TextStyle(),
                                //     ),
                                //   ],
                                // ),
                                content: Container(
                                  width: double.maxFinite,
                                  height: 150,
                                  child: FutureBuilder(
                                    future: OFFLINEPRODUCTSYNC()
                                        .offlineDataSync(
                                            brands: AppStrings.brands),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Column(
                                          children: [
                                            Lottie.asset(
                                                'assets/logo/syncing.json',
                                                height: 120),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Syncing...",
                                              style: TextStyle(
                                                  color: AppThemes.modernBlue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.error,
                                              size: 60,
                                              color: AppThemes.modernRed,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Sync failed',
                                              style: TextStyle(
                                                  color:
                                                      AppThemes.modernSexyRed,
                                                  fontSize: 24),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ZoomTapAnimation(
                                              onTap: () {
                                                Get.closeCurrentSnackbar();
                                                Get.back(); // Close the dialog
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppThemes.modernBlue),
                                                child: Center(
                                                  child: Text(
                                                    "Okay",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        // Navigator.pop(
                                        //     context); // Close the dialog
                                        // Sync completed successfully
                                        // You can add any necessary logic or UI updates here
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.done,
                                              size: 60,
                                              color: AppThemes.modernGreen,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Sync completed',
                                              style: TextStyle(
                                                  color: AppThemes.modernGreen,
                                                  fontSize: 24),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ZoomTapAnimation(
                                              onTap: () {
                                                Get.closeCurrentSnackbar();
                                                Get.back(); // Close the dialog
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppThemes.modernGreen),
                                                child: Center(
                                                  child: Text(
                                                    "Okay",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                                actionsPadding: EdgeInsets.all(10),
                                actions: [],
                              );
                            },
                          );
                          // await OFFLINEPRODUCTSYNC()
                          //     .offlineDataSync(brands: AppStrings.brands)
                          //     .then({Get.back()});
                          // Fluttertoast.showToast(
                          //   msg: "SYNC STARTED!",
                          //   backgroundColor: AppThemes.modernBlue,
                          // );
                          // await OFFLINEPRODUCTSYNC()
                          //     .offlineDataSync(brands: AppStrings.brands);
                        },
                      ),
                      menuItem(
                        icon: FontAwesomeIcons.chartLine,
                        color: AppThemes.modernChocolate,
                        title: "Statistics",
                        valid: true,
                        function: () {
                          Get.toNamed(
                            Routes.STATISTICSPAGE,
                            id: Constants.nestedNavigationNavigatorId,
                          );
                        },
                      ),
                      menuItem(
                        icon: Icons.discount,
                        color: Colors.pink,
                        title: "Offers",
                        valid: false,
                        function: () {
                          Get.toNamed(
                            Routes.OFFERINFO,
                            id: Constants.nestedNavigationNavigatorId,
                          );
                        },
                      ),
                      menuItem(
                        icon: Icons.tv,
                        color: Colors.green,
                        title: "Promotionals",
                        valid: false,
                        function: () {
                          Get.toNamed(
                            Routes.PROMOTIONALADS,
                            id: Constants.nestedNavigationNavigatorId,
                          );
                        },
                      ),
                      menuItem(
                        icon: Icons.list,
                        color: Colors.deepPurple,
                        title: "Leadership Board",
                        valid: false,
                        function: () {
                          Get.toNamed(
                            Routes.LEADERSHIPPAGE,
                            id: Constants.nestedNavigationNavigatorId,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
      )),
    );
  }

  static menuItem(
      {required IconData icon,
      required Color color,
      required String title,
      required VoidCallback function,
      required bool valid}) {
    return ZoomTapAnimation(
      onTap: valid ? function : () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        // EdgeInsets.only(
        //                             left: index % 2 == 0
        //                                 ? 8
        //                                 : 0,
        //                             right: index % 2 != 0
        //                                 ? 8
        //                                 : 0),
        decoration: BoxDecoration(
            color: valid ? color.withOpacity(0.6) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: valid ? color.withOpacity(0.5) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.all(15),
              child: Icon(
                icon,
                size: 50,
                color: valid
                    ? Colors.white.withOpacity(0.8)
                    : Colors.grey.shade500,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: valid
                      ? Colors.white.withOpacity(0.8)
                      : Colors.grey.shade500,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 200; // Adjust this value based on your item's width
    final crossAxisCount = (screenWidth / itemWidth).floor();
    if (crossAxisCount == 1) {
      return 2;
    } else {
      return crossAxisCount;
    }
  }

  static Widget offerItem({required String dataLink}) {
    return Container(
      margin: EdgeInsets.all(10),
      // height: 175,
      // width: 175,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.grey.shade400)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: dataLink,
          // height: 160,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (ctx, url, err) => Image.asset(
            'assets/images/noprevvec.jpg',
            height: 70,
          ),
        ),
      ),
    );
  }

  static Widget offerItemVideo({required String dataLink}) {
    VideoPlayerController videoPlayerController =
        new VideoPlayerController.network(dataLink);

    ChewieController chewieController = new ChewieController(
        videoPlayerController: videoPlayerController,
        // autoPlay: true,
        looping: true,
        autoInitialize: true,
        showOptions: false,
        showControls: false,
        aspectRatio: 0.9);

    return Container(
      margin: EdgeInsets.all(10),
      // height: 500,
      // // width: 190,
      // height: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.7, color: Colors.grey)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  static offerDialogue({required String link, required int type}) {
    VideoPlayerController? videoPlayerController;
    ChewieController? chewieController;
    YoutubePlayerController? youtubePlayerController;
    if (link.contains("youtube")) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(link)!,
        flags: YoutubePlayerFlags(
          hideControls: true,
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      videoPlayerController = new VideoPlayerController.network(link);

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        looping: true,
        autoInitialize: true,
        showOptions: true,
        autoPlay: true,
        draggableProgressBar: false,
        materialProgressColors: ChewieProgressColors(),
        allowFullScreen: false,
        allowMuting: false,
        showControls: false,
        aspectRatio: 1,
      );
    }

    Get.generalDialog(pageBuilder: (ctx, anim1, anim2) {
      return MediaQuery(
        data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Promotion",
                style: TextStyle(),
              ),
              // InkWell(
              //   onTap: () async {
              //     chewieController.dispose();
              //     videoPlayerController.dispose();
              //     Get.back();
              //   },
              //   child: Container(
              //     // padding: EdgeInsets.all(5),
              //     child: Center(
              //         child: Icon(
              //       Icons.close,
              //       color: Colors.red.shade800,
              //       size: 20,
              //     )),
              //     decoration: BoxDecoration(
              //         color: Colors.grey.shade200,
              //         borderRadius: BorderRadius.circular(100)),
              //   ),
              // )
            ],
          ),
          content: type == 0
              ? Container(height: 400, child: offerItem(dataLink: link))
              : Container(
                  height: 400,
                  // margin: EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  //   border: Border.all(width: 0.7, color: Colors.grey),
                  // ),
                  child: link.contains("youtube")
                      ? YoutubePlayer(
                          controller: youtubePlayerController!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.red,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Chewie(
                            controller: chewieController!,
                          ),
                        ),
                ),
          actionsPadding: EdgeInsets.all(10),
          actions: [
            InkWell(
              onTap: () async {
                chewieController?.dispose();
                videoPlayerController?.dispose();
                youtubePlayerController?.dispose();
                Get.back();
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: AppThemes.modernGreen,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text("CLOSE", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      );
    });
  }

  // static showDialog({required SimpleFontelicoProgressDialog dialog}) async {
  //   dialog.show(
  //       message: 'Syncing...', type: SimpleFontelicoProgressDialogType.normal);

  //   await OFFLINEPRODUCTSYNC()
  //       .offlineDataSync(brands: AppStrings.brands)
  //       .then((v) {
  //     dialog.hide();
  //   });
  // }
}

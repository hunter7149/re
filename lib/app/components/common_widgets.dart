import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sales/app/components/AppColors.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../api/service/prefrences.dart';
import '../config/app_assets.dart';
import '../modules/noticescreen/controllers/noticescreen_controller.dart';

class COMMONWIDGET {
  static underDev() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.ASSET_UNDERDEV,
            height: 300,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "This feature is under development.Please wait for the next update.",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomTapAnimation(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: AppThemes.PrimaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static restriction({required String message}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.ASSET_RESTRICTION,
            height: 300,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "${message}",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomTapAnimation(
                onTap: () {
                  Get.offNamed(Routes.LOGIN);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: AppThemes.PrimaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static loginInput(
      {required String hinttext,
      required TextEditingController controller,
      required bool obsecure}) {
    return TextField(
      controller: controller,
      obscureText: obsecure,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppThemes.modernBlue,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: AppThemes.modernBlue,
          )),
    );
  }

  static button(
      {required String title, required VoidCallback funtion, double? height}) {
    return ZoomTapAnimation(
      onTap: funtion,
      child: Container(
        height: height ?? 40,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: AppThemes.modernBlue,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  static addtoCart(
      {required String title,
      required VoidCallback funtion,
      double? height,
      double? margin,
      Color? color}) {
    return ZoomTapAnimation(
      onTap: funtion,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin ?? 10),
        height: height ?? 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: color ?? APPCOLORS.mainBlue,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  static saveNotification(RemoteMessage message) {
    if (message.notification != null) {
      if (message.notification!.title!.toLowerCase().contains("restrict")) {
        Pref.writeData(key: Pref.RESTRICTION_STATUS, value: true);
        Pref.writeData(
            key: Pref.RESTRICTION_MESSAGE, value: message.notification!.body);
        Get.offNamed(Routes.RESTRICTION);
      } else if (message.notification!.title!.toLowerCase().contains("allow")) {
        Pref.writeData(key: Pref.RESTRICTION_STATUS, value: false);
        Pref.removeData(key: Pref.RESTRICTION_MESSAGE);
      } else {}
    }
    RxList<dynamic> noticelist = <dynamic>[].obs;
    print(
        "Recieved data type: ---------------- ${Pref.readData(key: Pref.NOTICE_LIST)}");
    noticelist.value = Pref.readData(key: Pref.NOTICE_LIST) ?? [];

    noticelist.refresh();
    if (message.notification != null) {
      Map<String, dynamic> data = {
        "title": message.notification!.title ?? "",
        "body": message.notification!.body ?? "",
      };

      noticelist.add(data);
      noticelist.refresh();
      // GetStorage().remove(Pref.NOTICE_LIST);
      Pref.writeData(key: Pref.NOTICE_LIST, value: noticelist);
    }
    Get.put(NoticescreenController());
    Get.find<NoticescreenController>().loadNotices();
    print(noticelist);
  }

  static globalAppBar(
      {IconData? leadingIcon,
      Color? leadingIconColor,
      Color? backIconColor,
      IconData? bacKIcon,
      required String tittle,
      required Callback backFunction,
      VoidCallback? leadingFunction,
      bool? backEnabled}) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 50.0,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leadingWidth: 30,
        titleTextStyle: TextStyle(color: Colors.grey.shade700),
        title: Text(tittle),
        actions: [
          // backEnabled == true
          //     ? IconButton(
          //         icon: Icon(Icons.arrow_back),
          //         // Image.asset("assets/images/back_arrow.jpg"),
          //         color: backIconColor ?? Colors.grey.shade700,
          //         tooltip: 'Comment Icon',
          //         onPressed: backFunction,
          //       )
          //     : Container()

          // //IconButton
          // //IconButton
        ], //<Widget>[]
        // backgroundColor: Colors.greenAccent[400],
        // elevation: 50.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // Image.asset("assets/images/back_arrow.jpg"),
          color: backIconColor ?? Colors.grey.shade700,
          tooltip: 'Comment Icon',
          onPressed: backFunction,
        ));
  }
}

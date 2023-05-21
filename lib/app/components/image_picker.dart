import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ImageAlert {
  dynamic controller;
  BuildContext context;
  ThemeData? theme;
  ImageAlert({required this.controller, required this.context, this.theme});

  final ImagePicker _picker = ImagePicker();
  show() => Get.generalDialog(
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
      pageBuilder: (bCtx, anim1, anim2) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Image'),
                  closeIcon(onTap: () {
                    Get.back();
                  }),
                ]),
            content: Container(
              child: Obx(() => controller.file.value != null
                  ? Container(
                      child:
                          Image.file(File(controller.file.value?.path ?? '')))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          Expanded(
                            child: btn(Icons.image, "Galary", () async {
                              await _picker
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) {
                                if (value != null) controller.setFile(value);
                              });
                            }),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: btn(Icons.camera_alt, "Camera", () async {
                              await _picker
                                  .pickImage(source: ImageSource.camera)
                                  .then((value) {
                                if (value != null) controller.setFile(value);
                              });
                            }),
                          ),
                        ])),
            ),
            actionsPadding: EdgeInsets.all(24),
            actions: [
              ZoomTapAnimation(
                onTap: () {
                  if (controller.file.value == null) {
                    Get.snackbar("Warning", "Please select a photo",
                        colorText: Colors.white,
                        backgroundColor: AppThemes.modernSexyRed,
                        animationDuration: Duration(seconds: 0),
                        borderRadius: 0);
                  } else {
                    controller.setImageFile(controller.file.value!);
                    controller.setFile(null);
                    Get.back();
                  }
                },
                child: Container(
                    height: 45,
                    width: Get.width,
                    child: Center(child: Text("Confirm"))),
              )
            ],
          ));

  btn(IconData icon, String text, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2.0,
                    color: Colors.grey.shade200,
                    offset: Offset.zero,
                    spreadRadius: 2)
              ]),
          height: 120,
          padding: EdgeInsets.all(12),
          child: Column(
            children: [Expanded(child: Icon(icon)), Text(text)],
          ),
        ),
      );

  closeIcon({required VoidCallback onTap}) => InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.shade200,
          ),
          child: Icon(
            Icons.close,
            color: Colors.grey.shade700,
          ),
        ),
      );
}

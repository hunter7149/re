import 'package:flutter/material.dart';
import 'package:red_tail/app/components/AppColors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class COMMONWIDGET {
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
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: APPCOLORS.mainBlue,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: APPCOLORS.mainBlue,
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
            color: APPCOLORS.mainBlue, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}

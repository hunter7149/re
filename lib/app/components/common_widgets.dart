import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
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

  static globalAppBar(
      {IconData? leadingIcon,
      Color? leadingIconColor,
      Color? backIconColor,
      IconData? bacKIcon,
      required String tittle,
      required Callback backFunction,
      VoidCallback? leadingFunction}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      toolbarHeight: 50.0,
      bottomOpacity: 0.0,
      elevation: 0.0,
      titleTextStyle: TextStyle(color: Colors.grey.shade700),

      title: Text(tittle),
      actions: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          // Image.asset("assets/images/back_arrow.jpg"),
          color: backIconColor ?? Colors.grey.shade700,
          tooltip: 'Comment Icon',
          onPressed: backFunction,
        ), //IconButton
        //IconButton
      ], //<Widget>[]
      // backgroundColor: Colors.greenAccent[400],
      // elevation: 50.0,
      leading: IconButton(
        icon: const Icon(Icons.library_books_rounded),
        tooltip: 'Menu Icon',
        color: Colors.grey.shade700,
        onPressed: leadingFunction ?? () {},
      ),
    );
  }
}

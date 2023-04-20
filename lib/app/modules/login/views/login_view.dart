import 'package:red_tail/app/components/AppColors.dart';
import 'package:red_tail/app/components/common_widgets.dart';

import '../../../components/custom_text_field.dart';
import '../../../components/login_top_shape.dart';
import '../../../components/primary_button.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              AppAssets.ASSET_APP_REMARK_LOGO,
              height: 96,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  COMMONWIDGET.loginInput(
                      controller: controller.email,
                      hinttext: "Enter your email",
                      obsecure: false),
                  SizedBox(
                    height: 20,
                  ),
                  passwordField(
                      hinttext: "Enter your password", controller: controller),
                  SizedBox(
                    height: 20,
                  ),
                  COMMONWIDGET.button(
                      title: "LOGIN",
                      funtion: () {
                        controller.requestLogin();
                        // controller.onTapLogin();
                      },
                      height: 50),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     Text(
                  //       'Dont have an account?',
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     Text(
                  //       ' Create Account',
                  //       style: TextStyle(
                  //           fontSize: 16, color: AppThemes.PrimaryDarkColor),
                  //     )
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  static passwordField(
      {required String hinttext, required LoginController controller}) {
    return Obx(() {
      return TextField(
        controller: controller.password,
        obscureText: controller.obsecure.value,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: AppThemes.modernBlue,
                width: 1,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                controller.obsecureUpdater();
              },
              child: Icon(
                Icons.visibility,
                color: AppThemes.modernBlue,
              ),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: AppThemes.modernBlue,
            )),
      );
    });
  }
}

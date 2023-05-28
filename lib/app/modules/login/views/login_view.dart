import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ProsteBezierCurve(
                  position: ClipPosition.bottom,
                  list: [
                    BezierCurveSection(
                      start: Offset(0, (screenheight / 2.7) - 25),
                      top: Offset(screenWidth / 4, screenheight / 2.7),
                      end: Offset(screenWidth / 2, (screenheight / 2.7) - 25),
                    ),
                    BezierCurveSection(
                      start: Offset(screenWidth / 2, (screenheight / 2.7) - 25),
                      top: Offset(
                          screenWidth / 4 * 3, (screenheight / 2.7) - 50),
                      end: Offset(screenWidth, screenheight / 2.7),
                    ),
                  ],
                ),
                child: Container(
                    height: screenheight / 2.7, color: Color(0xFFD71921)),
              ),
              ClipPath(
                clipper: ProsteBezierCurve(
                  position: ClipPosition.bottom,
                  list: [
                    BezierCurveSection(
                      start: Offset(
                          0,
                          (screenheight / 3) -
                              25), //Screen divided by 3 means it will go less to the bottom than dividng by 2.7,
                      top: Offset(screenWidth / 4, screenheight / 3),
                      end: Offset(screenWidth / 2, (screenheight / 3) - 25),
                    ),
                    BezierCurveSection(
                      start: Offset(screenWidth / 2, (screenheight / 3) - 25),
                      top: Offset(screenWidth / 4 * 3, (screenheight / 3) - 50),
                      end: Offset(screenWidth, screenheight / 3),
                    ),
                  ],
                ),
                child: Container(
                  height: screenheight / 3,
                  color: AppThemes.mainBlue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.ASSET_APP_REMARK_LOGO,
                          height: 96,
                        ),
                        Image.asset(
                          'assets/logo/login_logo_hb.png',
                          height: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36),
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
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => controller.isLogingIn.value
                        ? SpinKitDoubleBounce(
                            color: AppThemes.mainBlue,
                          )
                        : ZoomTapAnimation(
                            onTap: () {
                              controller.requestLogin();
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: AppThemes.PrimaryColor,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ))
                  ],
                ),
                // COMMONWIDGET.button(
                //     title: "LOGIN",
                //     funtion: () {
                //       controller.requestLogin();
                //       // controller.onTapLogin();
                //     },
                //     height: 50),
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
              borderRadius: BorderRadius.circular(30),
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

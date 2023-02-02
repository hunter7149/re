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
          children: [
            //LoginTopBar(),
            const SizedBox(height: 140),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.ASSET_APP_REMARK_LOGO,
                    height: 96,
                  ),
                  const SizedBox(height: 16),
                  // const Text(
                  //   'You can buy anything from here.',
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 20),
                TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                    ),
                    prefixIcon: IconTheme(
                      data: IconThemeData(
                        color: Color(0xFF00416B),
                      ),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
                  const SizedBox(height: 10),
                  TextField(
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xFF00416B),
                          width: 3,
                        ),
                      ),
                      prefixIcon: IconTheme(
                        data: IconThemeData(
                          color: Color(0xFF00416B),
                        ),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    onClick: () {
                      controller.onTapLogin();
                    },
                    text: 'LOGIN',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Dont have an account?',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ' Create Account',
                        style: TextStyle(
                            fontSize: 16, color: AppThemes.PrimaryDarkColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

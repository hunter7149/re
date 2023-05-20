import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const Color PrimaryColor = Color(0xFF00416B);
  static const Color PrimaryLightColor = Color.fromARGB(255, 194, 230, 254);
  static const Color PrimaryDarkColor = Color.fromARGB(255, 72, 52, 187);
  static const Color PrimaryDarkColorAl = Color(0xFF00416B);
  static const Color AccentColor = Color(0xffF1C40F);
  static const Color bgColor = Color(0xFFE9EBF0);
  static const Color lebelTxtColor = Color(0xFF595D69);
  static Color mainBlue = Color(0xFF00416B);
  static Color greyColor = Colors.blueGrey.shade100;
  static Color modernGreen = Color(0xff25ae7a);
  static Color modernPlantation = Color(0xff4c6e81);
  static Color modernLightBrown = Color(0xffF49F51);
  static Color modernRed = Color(0xFFff595e);
  static Color modernSexyRed = Color(0xffE94C42);
  static Color modernCoolPink = Color(0xffD7415e);
  static Color modernBlue = Color(0xff007ea7);
  static Color sexySkyBlue = Color(0xffDCF4F5);
  static Color modernPurple = Color(0xff6867AC);
  static Color modernChocolate = Color(0xff854442);
  static Color modernCoral = Color(0xffF54D3D);
  static Color modernChocolate2 = Color(0xff704F4F);
  static Color modernDeepSea = Color(0xff0F3D3E);

  static ThemeData lightTheme() => ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppThemes.PrimaryDarkColor,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0,
          backgroundColor: PrimaryColor,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        scaffoldBackgroundColor: PrimaryColor,
        primaryColor: PrimaryColor,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: PrimaryColor),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelStyle: TextStyle(color: lebelTxtColor, fontSize: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppThemes.PrimaryColor),
            textStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
          ),
        ),
      );
}

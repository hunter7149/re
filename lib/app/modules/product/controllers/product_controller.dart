import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/config/app_themes.dart';

class ProductController extends GetxController {
  List<Color> randomeColor = [
    AppThemes.modernBlue,
    AppThemes.modernGreen,
    AppThemes.modernPurple,
    AppThemes.modernRed,
    AppThemes.modernCoolPink,
    AppThemes.modernSexyRed,
    AppThemes.modernChocolate,
    AppThemes.modernPlantation
  ];

  RxList<dynamic> mainProductList = <dynamic>[].obs;

  RxList<dynamic> categories = <dynamic>[].obs;
  RxList<dynamic> prdct = <dynamic>[].obs;

  RxList<String> brands = [
    'acnol',
    'blazoskin',
    'elanvenezia',
    'tylox',
    'herlan',
    'lily',
    'nior',
    'orix',
    'siodil',
    'sunbit',
  ].obs;

  loadData() async {
    brands.value = [
      'acnol',
      'blaze o skin',
      'elanvenezia',
      'tylox',
      'herlan',
      'lily',
      'nior',
      'orix',
      'siodil',
      'sunbit',
    ];
    brands.refresh();
    // OFFLINEPRODUCTSYNC().offlineDataSync(brands: brands);
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

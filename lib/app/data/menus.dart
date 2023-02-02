import '../config/app_assets.dart';
import '../models/menu.dart';
import 'package:flutter/material.dart';

var menus = [
  MenuModel(
      tittle: 'Home Care',
      image: AppAssets.ASSET_PRODUCT_IMAGE,
      color: Colors.blue[100]),
  MenuModel(tittle: 'Beauty', color: Colors.yellow[100]),
  MenuModel(tittle: 'Hygiene', color: Colors.green[100]),
  MenuModel(tittle: 'Cosmetics', color: Colors.red[100]),
];

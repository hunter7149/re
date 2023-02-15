import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  RxList<dynamic> data = <dynamic>["as", "bs"].obs;
  final RxString argumentToDetailPage = RxString('you are the best!');
  final RxString argumentFromDetailPage = RxString('no argument yet');
  RxList<Map<String, dynamic>> urls = <Map<String, dynamic>>[
    {
      "link":
          "https://montresorbd.com/wp-content/uploads/2021/03/Meringue-1.jpg",
      "type": 0
    },
    {
      "link":
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4",
      "type": 1
    },
    {
      "link":
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4",
      "type": 1
    },
    {
      "link":
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4",
      "type": 1
    },
  ].obs;

  Future goToDetailPage(var index) async {
    var result;
    if (index == 0) {
      Get.toNamed(Routes.ORDERHOME, id: Constants.nestedNavigationNavigatorId);
    } else if (index == 1) {
      result = await Get.toNamed(Routes.PRODUCT,
          arguments: argumentToDetailPage.value,
          id: Constants.nestedNavigationNavigatorId);
      argumentFromDetailPage.value = result == null
          ? 'No argument'
          : (result as double).toStringAsFixed(0);
    } else {
      print('button $index');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

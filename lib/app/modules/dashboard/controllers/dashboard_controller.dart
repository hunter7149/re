import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';
import '../../../sync/products/offlineproductsync.dart';

class DashboardController extends GetxController {
  RxList<dynamic> data = <dynamic>["as", "bs"].obs;
  final RxString argumentToDetailPage = RxString('you are the best!');
  final RxString argumentFromDetailPage = RxString('no argument yet');
  RxList<Map<String, dynamic>> urls = <Map<String, dynamic>>[
    {
      "link":
          "https://scontent-sin6-2.cdninstagram.com/v/t51.2885-15/321196686_502727611988849_2682759865500846730_n.webp?stp=dst-jpg_e35&_nc_ht=scontent-sin6-2.cdninstagram.com&_nc_cat=105&_nc_ohc=5WgzPBoj-skAX-6FQ0j&edm=AP_V10EBAAAA&ccb=7-5&oh=00_AfBRi4b0_Sa0pvuEQWiUZwcHSfQM3nJ3jnoq6KHvkhBTCA&oe=643C8A90&_nc_sid=4f375e.jpg",
      "type": 0
    },
    {
      "link":
          "https://scontent-sin6-4.cdninstagram.com/v/t51.2885-15/325163181_561365272306959_3614961255418031332_n.webp?stp=dst-jpg_e35&_nc_ht=scontent-sin6-4.cdninstagram.com&_nc_cat=103&_nc_ohc=4b3MSNws7iUAX-1mTWw&edm=AP_V10EBAAAA&ccb=7-5&oh=00_AfBhrzgT_X9KFy4ZJsemSrTrghrH2NeqEK_1K6oUpSGs-Q&oe=643D3C8B&_nc_sid=4f375e.jpg",
      "type": 0
    },
    {
      "link":
          "https://scontent-sin6-3.cdninstagram.com/v/t51.2885-15/325532289_688561939674642_4020122134276188352_n.webp?stp=dst-jpg_e35&_nc_ht=scontent-sin6-3.cdninstagram.com&_nc_cat=106&_nc_ohc=n5vqAKFeUjsAX_fXtFV&edm=AP_V10EBAAAA&ccb=7-5&oh=00_AfC5ffMGiVqcD6kwn-d-Z88oUI4a-y2xNKQnNo7fCXQidA&oe=643CE157&_nc_sid=4f375e.jpg",
      "type": 0
    },
    {
      "link":
          "https://scontent-sin6-2.cdninstagram.com/v/t51.2885-15/292994728_5280264228754532_2416232431058552638_n.jpg?stp=dst-jpg_e35_p1080x1080&_nc_ht=scontent-sin6-2.cdninstagram.com&_nc_cat=108&_nc_ohc=t2CnAxFDwvcAX_RcH0M&edm=AP_V10EBAAAA&ccb=7-5&oh=00_AfDTvY8egQvfGIemdqy1CJUMo6_sN821nur-ZNwwHxCJRA&oe=643CB7D1&_nc_sid=4f375e.jpg",
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
  argumentUpdater({required double result}) {
    argumentFromDetailPage.value = result.toStringAsFixed(0);
    update();
  }

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
    OFFLINEPRODUCTSYNC().offlineDataSync(brands: [
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
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

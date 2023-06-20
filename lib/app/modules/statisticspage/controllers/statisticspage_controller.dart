import 'package:get/get.dart';

import '../../../models/chartDATA.dart';

class StatisticspageController extends GetxController {
  //TODO: Implement StatisticspageController
  List<ChartData> topSeller = [
    ChartData('Durjoy', 99),
    ChartData('Shawon', 80),
    ChartData('Orid', 85),
    ChartData('Khalid', 70),
    ChartData('Oalid', 90)
  ];

  List<ChartData> brandPerCall = [
    ChartData('Nior', 1000),
    ChartData('Blaze O Skin', 800),
    ChartData('Herlan', 1200),
    ChartData('Orix', 1120),
    ChartData('Sunbit', 500),
    ChartData('Lily', 700),
    ChartData('Tylox', 800),
    ChartData('Elan Venezia', 200),
    ChartData('Acnol', 300),
    ChartData('Siodil', 1500),
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

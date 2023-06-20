import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../constants.dart';
import '../../../models/chartDATA.dart';
import '../controllers/statisticspage_controller.dart';

class StatisticspageView extends GetView<StatisticspageController> {
  const StatisticspageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: COMMONWIDGET.globalAppBar(
            tittle: "Statistics",
            backFunction: () {
              Get.back(
                id: Constants.nestedNavigationNavigatorId,
              );
            }),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  // height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 5, color: AppThemes.modernGreen),
                      borderRadius: BorderRadius.circular(5)),
                  child: SfCartesianChart(
                      primaryXAxis:
                          CategoryAxis(title: AxisTitle(text: "Name")),
                      primaryYAxis:
                          NumericAxis(title: AxisTitle(text: "Points")),
                      // Chart title
                      title: ChartTitle(text: 'Top sellers'),
                      // Enable legend
                      // legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <BarSeries<ChartData, String>>[
                        BarSeries<ChartData, String>(
                            // borderWidth: 2,
                            sortingOrder: SortingOrder.ascending,
                            borderColor: Colors.red,
                            color: AppThemes.modernGreen,
                            dataSource: controller.topSeller,
                            sortFieldValueMapper: (ChartData sales, _) =>
                                sales.value,
                            xAxisName: "Points",
                            xValueMapper: (ChartData sales, _) => sales.title,
                            yValueMapper: (ChartData sales, _) => sales.value,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  // height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: AppThemes.modernBlue),
                      borderRadius: BorderRadius.circular(5)),
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Brand per call'),
                      // Enable legend
                      // legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <BarSeries<ChartData, String>>[
                        BarSeries<ChartData, String>(
                            // borderWidth: 2,
                            sortingOrder: SortingOrder.ascending,
                            borderColor: Colors.blue,
                            color: AppThemes.modernBlue,
                            dataSource: controller.brandPerCall,
                            sortFieldValueMapper: (ChartData sales, _) =>
                                sales.value,
                            xAxisName: "Points",
                            xValueMapper: (ChartData data, _) => data.title,
                            yValueMapper: (ChartData data, _) => data.value,
                            name: 'BPC',
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}

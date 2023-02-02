import 'package:red_tail/app/modules/leadershippage/bindings/leadershippage_binding.dart';
import 'package:red_tail/app/modules/leadershippage/views/leadershippage_view.dart';
import 'package:red_tail/app/modules/offerinfo/views/offerinfo_view.dart';
import 'package:red_tail/app/modules/orderHome/bindings/Order_Home_Binding.dart';
import 'package:red_tail/app/modules/orderHome/views/order_home_view.dart';
import 'package:red_tail/app/modules/product/bindings/product_binding.dart';
import 'package:red_tail/app/modules/product/views/product_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:red_tail/app/modules/promotionalads/bindings/promotionalads_binding.dart';
import 'package:red_tail/app/modules/promotionalads/views/promotionalads_view.dart';
import 'package:red_tail/app/modules/statisticspage/bindings/statisticspage_binding.dart';
import 'package:red_tail/app/modules/statisticspage/views/statisticspage_view.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';
import '../../account/views/account_view.dart';
import '../../cart/views/cart_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../home/views/home_view.dart';
import '../../productc/bindings/productc_binding.dart';
import '../../productc/views/productc_view.dart';
import '../../services/views/services_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/app_themes.dart';
import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            Navigator(
              key: Get.nestedKey(Constants.nestedNavigationNavigatorId),
              initialRoute: Routes.DASHBOARD,
              onGenerateRoute: (routeSettings) {
                print('hi-${routeSettings.name}');
                if (routeSettings.name == Routes.DASHBOARD) {
                  return MaterialPageRoute(builder: (context) {
                    return DashboardView();
                  });
                } else if (routeSettings.name == Routes.PRODUCT) {
                  return GetPageRoute(
                      routeName: Routes.PRODUCT,
                      page: () => ProductView(
                            argument: routeSettings.arguments as String,
                          ),
                      binding: ProductBinding());
                } else if (routeSettings.name == Routes.PRODUCTC) {
                  return GetPageRoute(
                      routeName: Routes.PRODUCTC,
                      page: () => ProductcView(
                            argument: routeSettings.arguments as String,
                          ),
                      binding: ProductcBinding());
                } else if (routeSettings.name == Routes.ORDERHOME) {
                  return GetPageRoute(
                      routeName: Routes.ORDERHOME,
                      page: () => OrderHomeView(),
                      binding: OrderHomeBinding());
                } else if (routeSettings.name == Routes.OFFERINFO) {
                  return GetPageRoute(
                      routeName: Routes.OFFERINFO,
                      page: () => OfferinfoView(),
                      binding: ProductcBinding());
                } else if (routeSettings.name == Routes.PROMOTIONALADS) {
                  return GetPageRoute(
                      routeName: Routes.PROMOTIONALADS,
                      page: () => PromotionaladsView(),
                      binding: PromotionaladsBinding());
                } else if (routeSettings.name == Routes.STATISTICSPAGE) {
                  return GetPageRoute(
                      routeName: Routes.STATISTICSPAGE,
                      page: () => StatisticspageView(),
                      binding: StatisticspageBinding());
                } else if (routeSettings.name == Routes.LEADERSHIPPAGE) {
                  return GetPageRoute(
                      routeName: Routes.LEADERSHIPPAGE,
                      page: () => LeadershippageView(),
                      binding: LeadershippageBinding());
                }
              },
            ),
            ServicesView(),
            CartView(),
            AccountView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => GestureDetector(
            onDoubleTap: () {
              Get.back(
                result: 2,
                id: Constants.nestedNavigationNavigatorId,
              );
            },
            child: BottomNavigationBar(
              backgroundColor: colorScheme.surface,
              selectedItemColor: colorScheme.onSurface,
              unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
              currentIndex: controller.tabIndex.value,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                    label: 'Service'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag), label: 'Activity'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box), label: 'Account'),
              ],
              onTap: controller.onTabClick,
            ),
          )),
    );
  }
}

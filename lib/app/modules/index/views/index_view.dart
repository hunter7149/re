import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:red_tail/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:red_tail/app/modules/leadershippage/bindings/leadershippage_binding.dart';
import 'package:red_tail/app/modules/leadershippage/views/leadershippage_view.dart';
import 'package:red_tail/app/modules/offerinfo/views/offerinfo_view.dart';
import 'package:red_tail/app/modules/orderHome/bindings/Order_Home_Binding.dart';
import 'package:red_tail/app/modules/orderHome/views/order_home_view.dart';
import 'package:red_tail/app/modules/orderpage/views/orderpage_view.dart';
import 'package:red_tail/app/modules/product/bindings/product_binding.dart';
import 'package:red_tail/app/modules/product/views/product_view.dart';
import 'package:red_tail/app/modules/productb/bindings/productb_binding.dart';
import 'package:red_tail/app/modules/productb/views/productb_view.dart';
import 'package:red_tail/app/modules/promotionalads/bindings/promotionalads_binding.dart';
import 'package:red_tail/app/modules/promotionalads/views/promotionalads_view.dart';
import 'package:red_tail/app/modules/statisticspage/bindings/statisticspage_binding.dart';
import 'package:red_tail/app/modules/statisticspage/views/statisticspage_view.dart';
import '../../../../constants.dart';
import '../../../routes/app_pages.dart';
import '../../account/views/account_view.dart';
import '../../cart/views/cart_view.dart';
import '../../dashboard/views/dashboard_view.dart';
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
    return WillPopScope(
        onWillPop: () async {
          if (controller.shouldQuit.value) {
            SystemNavigator.pop(animated: true);
            return true;
          } else {
            print("not exit");
            controller.updateShouldQuit();
            Fluttertoast.showToast(msg: "Tap twice to exit!");
            return false;
          }
        },
        child: Scaffold(
          body: Obx(
            () => IndexedStack(
              index: controller.tabIndex.value,
              children: [
                Navigator(
                  key: Get.nestedKey(Constants.nestedNavigationNavigatorId),
                  initialRoute: Routes.DASHBOARD,
                  onGenerateRoute: (routeSettings) {
                    print('The requested page route is:-${routeSettings.name}');
                    if (routeSettings.name == Routes.DASHBOARD) {
                      // GetPageRoute(
                      //     routeName: Routes.DASHBOARD,
                      //     page: () => DashboardView(),
                      //     binding: DashboardBinding());
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
                                argument: routeSettings.arguments,
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
                    } else if (routeSettings.name == Routes.PRODUCTB) {
                      return GetPageRoute(
                          routeName: Routes.PRODUCTB,
                          page: () => ProductbView(
                                argument: routeSettings.arguments,
                              ),
                          binding: ProductbBinding());
                    }
                  },
                ),
                ServicesView(),
                CartView(),
                OrderpageView(),
                AccountView(),
              ],
            ),
          ),
          bottomNavigationBar: Obx(() => GestureDetector(
                onDoubleTap: () {
                  Get.back(
                    result: 1,
                    id: Constants.nestedNavigationNavigatorId,
                  );
                },
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  backgroundColor: Colors.white,
                  selectedItemColor: AppThemes.modernGreen,
                  unselectedItemColor: Colors.grey.shade800,
                  currentIndex: controller.tabIndex.value,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.apps,
                          size: 30,
                        ),
                        label: 'Service'),
                    BottomNavigationBarItem(
                        icon: Obx(() => Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                    // top: -10,
                                    // left: 0,
                                    // bottom: 0,
                                    // right: 0,
                                    child: Icon(
                                  FontAwesomeIcons.cartShopping,
                                  // size: 40,
                                )),
                                controller.hasNewItem.value
                                    ? Positioned(
                                        left: 8,
                                        top: 0,
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Center(
                                            child: Text(
                                              "${controller.numberOfItem.value < 9 ? controller.numberOfItem.value : "9+"}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            )),
                        label: 'Cart'),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.shoppingBag),
                        label: 'Orders'),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.listUl), label: 'More'),
                  ],
                  onTap: controller.onTabClick,
                ),
              )),
        ));
  }
}

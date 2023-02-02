import 'package:red_tail/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:red_tail/app/modules/dashboard/views/dashboard_view.dart';
import 'package:red_tail/app/modules/orderHome/bindings/Order_Home_Binding.dart';
import 'package:red_tail/app/modules/orderHome/views/order_home_view.dart';
import 'package:red_tail/app/modules/product/bindings/product_binding.dart';
import 'package:red_tail/app/modules/product/views/product_view.dart';
import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/productc/bindings/productc_binding.dart';
import '../modules/productc/views/productc_view.dart';
import '../modules/services/bindings/services_binding.dart';
import '../modules/services/views/services_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () =>  ProductView(argument: 'default argument',),
      binding: ProductBinding (),
    ),

    GetPage(
      name: _Paths.PRODUCTC,
      page: () =>  ProductcView(argument: 'default argument',),
      binding: ProductcBinding (),
    ),
    GetPage(
      name: _Paths.ORDERHOME,
      page: () =>  OrderHomeView(),
      binding: OrderHomeBinding (),
    ),
  ];
}

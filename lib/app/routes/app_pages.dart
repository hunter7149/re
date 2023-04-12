import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/leadershippage/bindings/leadershippage_binding.dart';
import '../modules/leadershippage/views/leadershippage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/offerinfo/bindings/offerinfo_binding.dart';
import '../modules/offerinfo/views/offerinfo_view.dart';
import '../modules/orderHome/bindings/Order_Home_Binding.dart';
import '../modules/orderHome/views/order_home_view.dart';
import '../modules/orderpage/bindings/orderpage_binding.dart';
import '../modules/orderpage/views/orderpage_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/productb/bindings/productb_binding.dart';
import '../modules/productb/views/productb_view.dart';
import '../modules/productc/bindings/productc_binding.dart';
import '../modules/productc/views/productc_view.dart';
import '../modules/promotionalads/bindings/promotionalads_binding.dart';
import '../modules/promotionalads/views/promotionalads_view.dart';
import '../modules/services/bindings/services_binding.dart';
import '../modules/services/views/services_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/statisticspage/bindings/statisticspage_binding.dart';
import '../modules/statisticspage/views/statisticspage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

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
      page: () => ProductView(
        argument: 'default argument',
      ),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTC,
      page: () => ProductcView(
        argument: 'default argument',
      ),
      binding: ProductcBinding(),
    ),
    GetPage(
      name: _Paths.ORDERHOME,
      page: () => OrderHomeView(),
      binding: OrderHomeBinding(),
    ),
    GetPage(
      name: _Paths.OFFERINFO,
      page: () => const OfferinfoView(),
      binding: OfferinfoBinding(),
    ),
    GetPage(
      name: _Paths.PROMOTIONALADS,
      page: () => const PromotionaladsView(),
      binding: PromotionaladsBinding(),
    ),
    GetPage(
      name: _Paths.STATISTICSPAGE,
      page: () => const StatisticspageView(),
      binding: StatisticspageBinding(),
    ),
    GetPage(
      name: _Paths.LEADERSHIPPAGE,
      page: () => const LeadershippageView(),
      binding: LeadershippageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTB,
      page: () => const ProductbView(),
      binding: ProductbBinding(),
    ),
    GetPage(
      name: _Paths.ORDERPAGE,
      page: () => const OrderpageView(),
      binding: OrderpageBinding(),
    ),
  ];
}

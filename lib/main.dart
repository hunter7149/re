import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/api/service/prefrences.dart';
import 'app/modules/underdevelopment/bindings/underdevelopment_binding.dart';
import 'app/modules/underdevelopment/views/underdevelopment_view.dart';
import 'app/routes/app_pages.dart';

// @pragma('vm:entry-point')
// onStart(ServiceInstance serviceInstance) {
//   Timer.periodic(Duration(seconds: 10), (timer) {
//     // Run the offlineDataSync() method
//     OFFLINEPRODUCTSYNC().offlineDataSync(brands: AppStrings.brands);

//     // Run the onlineSync() method
//     // OFFLINEORDERSYNC().onlineSync();
//   });
//   return true;
// }

// initializeBackgroundService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//     ),
//   );
//   service.startService();
// }

Future<void> main() async {
  await GetStorage.init("remark_sales_app_data");
  WidgetsFlutterBinding.ensureInitialized();
  // DartPluginRegistrant.ensureInitialized();

  String synctime = Pref.readData(key: "lastSyncTime") ?? "0";
  if (synctime == " 0") {
    print("Never synced");
  } else {
    print("Synced before");
  }

  HttpOverrides.global = MyHttpOverrides();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      unknownRoute: GetPage(
        name: '/underdevelopment',
        page: () => const UnderdevelopmentView(),
        binding: UnderdevelopmentBinding(),
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

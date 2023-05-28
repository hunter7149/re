import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/components/app_strings.dart';
import 'package:sales/app/sync/products/offlineordersync.dart';
import 'package:sales/app/sync/products/offlineproductsync.dart';
import 'package:workmanager/workmanager.dart';
import 'app/api/service/prefrences.dart';
import 'app/modules/underdevelopment/bindings/underdevelopment_binding.dart';
import 'app/modules/underdevelopment/views/underdevelopment_view.dart';
import 'app/routes/app_pages.dart';

// @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // await OFFLINEORDERSYNC().onlineSync();
//     await OFFLINEPRODUCTSYNC().offlineDataSync(brands: AppStrings.brands);
//     //  await Repository().getAllProducts(body: {'brand':'nior'}).then((value) => print(value););
//     //   OFFLINEPRODUCTSYNC().offlineDataSync(brands: AppStrings.brands);
//     return Future.value(true);
//   });
// }

// appSync() async {
//   // await GetStorage.init("remark_sales_app_data");
//   dynamic data = Pref.readData(key: Pref.LOGIN_INFORMATION) ?? 'FAILED';
//   print("----------");
//   print(data);
//   print("----------");
//   OFFLINEPRODUCTSYNC().offlineDataSync(brands: AppStrings.brands);
//   print(
//       "----------------------------------------------------------------------------");
//   print("${DateTime.now()}");
// }
@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  Timer.periodic(Duration(seconds: 10), (timer) {
    // Run the offlineDataSync() method
    OFFLINEPRODUCTSYNC().offlineDataSync(brands: AppStrings.brands);

    // Run the onlineSync() method
    // OFFLINEORDERSYNC().onlineSync();
  });
}

iniitializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      // onBackground: onIosBackground,
    ),
  );
  service.startService();
}

Future<void> main() async {
  await GetStorage.init("remark_sales_app_data");
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );
  // Workmanager().registerPeriodicTask("appSync", "AppSync",
  //     frequency: Duration(seconds: 10));

  String synctime = Pref.readData(key: "lastSyncTime") ?? "0";
  if (synctime == " 0") {
    print("Never synced");
  } else {
    print("Synced before");
  }

  // await GetStorage.init();
  // Platform.isAndroid ? await FirebaseService.initialize() : () {};
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

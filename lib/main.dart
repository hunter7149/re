import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';
import 'app/routes/app_pages.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    appSync();
    return Future.value(true);
  });
}

appSync() {
  print(
      "----------------------------------------------------------------------------");
  print("${DateTime.now()}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerPeriodicTask("appSync", "AppSync",
      frequency: Duration(seconds: 10));

  await GetStorage.init();
  String synctime = await GetStorage().read("lastSyncTime") ?? "0";
  if (synctime == "0") {
    print("Never synced");
  } else {
    print("Synced before");
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

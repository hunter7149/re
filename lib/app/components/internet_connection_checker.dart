import 'package:connectivity_plus/connectivity_plus.dart';

class ICHECKER {
  //--------------------------Code to check network-----------------------//
  static Future<bool> checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }

  // backgroundInternetChecker() {
  //   var listener = InternetConnectionChecker().onStatusChange.listen((status) {
  //     switch (status) {
  //       case InternetConnectionStatus.connected:
  //         print('Data connection is available.');
  //         break;
  //       case InternetConnectionStatus.disconnected:
  //         print('You are disconnected from the internet.');
  //         break;
  //     }
  //   });
  // }
}

import 'package:get_storage/get_storage.dart';

class Pref {
  static final box = GetStorage('remark_sales_app_data');
  static var FCM_TOKEN = "fcm_token";
  static var DEVICE_ID = 'device-id';
  static var LOGIN_INFORMATION = 'login_information';
  static var USER_ID = 'user_id';
  static var USER_PASSWORD = "user_password";
  static var DEVICE_IDENTITY = 'device-identity';
  static var BEAT_NAME = 'beat_name';
  static var CUSTOMER_NAME = 'customer_name';
  static var NOTICE_LIST = "notice_list";
  static var CUSTOMER_CODE = "customer_code";
  static var BEATLIST = "beatlist";
  static var CUSTOMERLIST = "customerlist";

  static void writeData({required String key, required dynamic value}) =>
      box.write(key, value);

  static dynamic readData({required String key}) => box.read(key);

  static void removeData({required String key}) => box.remove(key);
}

import 'package:get_storage/get_storage.dart';

class Pref {
  static final box = GetStorage('remark_sales_app_data');
  static var FCM_TOKEN = "fcm_token_sales";
  static var DEVICE_ID = 'device-id_sales';
  static var LOGIN_INFORMATION = 'login_information_sales';
  static var USER_ID = 'user_id_sales';
  static var USER_PASSWORD = "user_password_sales";
  static var DEVICE_IDENTITY = 'device-identity_sales';
  static var BEAT_NAME = 'beat_name_sales';
  static var CUSTOMER_NAME = 'customer_name_sales';
  static var NOTICE_LIST = "notice_list_sales";
  static var CUSTOMER_CODE = "customer_code_sales";
  static var BEATLIST = "beatlist_sales";
  static var CUSTOMERLIST = "customerlist_sales";
  static var RESTRICTION_STATUS = 'restriction_status_sales';
  static var RESTRICTION_MESSAGE = 'restriction_message_sales';
  static var OFFLINE_DATA = 'offline_data_product_sales';
  static var OFFLINE_PRICE = 'offline_price_value';
  static var OFFLINE_PRICE_ID = 'offline_selected_price_id';
  static var OFFLINE_CUSTOMIZED_DATA = "offline_customized_product_data";
  static void writeData({required String key, required dynamic value}) =>
      box.write(key, value);

  static dynamic readData({required String key}) => box.read(key);

  static void removeData({required String key}) => box.remove(key);
}

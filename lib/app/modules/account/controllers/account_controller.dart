import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/routes/app_pages.dart';

class AccountController extends GetxController {
  logOut() async {
    // await removeData();
    Pref.removeData(key: Pref.LOGIN_INFORMATION);
    Pref.readData(key: Pref.USER_ID);
    Pref.removeData(key: Pref.USER_PASSWORD);
    // await GetStorage().remove(Pref.FCM_TOKEN);
    Get.offNamed(Routes.LOGIN);
  }

  removeData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference stringsCollection = firestore.collection('fcm_token');
    String emailText = Pref.readData(key: Pref.USER_ID);

    try {
      await stringsCollection.doc(emailText).delete();
      print('Data removed successfully for $emailText');
    } catch (e) {
      print('Error removing data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

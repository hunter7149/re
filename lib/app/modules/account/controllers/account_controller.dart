import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales/app/api/firebase/pushnotificationservice.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/routes/app_pages.dart';

class AccountController extends GetxController {
  logOut() async {
    // await removeData();
    await GetStorage().remove(Pref.LOGIN_INFORMATION).then((value) async {
      await GetStorage().remove(Pref.USER_ID);
      await GetStorage().remove(Pref.USER_PASSWORD);
      // await GetStorage().remove(Pref.FCM_TOKEN);
      Get.offNamed(Routes.LOGIN);
    });
  }

  removeData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference stringsCollection = firestore.collection('fcm_token');
    String emailText = GetStorage().read(Pref.USER_ID);

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

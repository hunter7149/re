import 'package:get/get.dart';

import '../../../api/service/prefrences.dart';

class NoticescreenController extends GetxController {
  RxList<Map<String, dynamic>> notices = <Map<String, dynamic>>[{}].obs;

  loadNotices() {
    final dynamic data = Pref.readData(key: Pref.NOTICE_LIST);
    if (data != null) {
      notices.value = List<Map<String, dynamic>>.from(data);
    }
    notices.refresh();

    update();
  }

  deleteNotice({required int index}) {
    notices.removeAt(index);
    notices.refresh();
    Pref.writeData(key: Pref.NOTICE_LIST, value: notices);
    update();
    loadNotices();
  }

  @override
  void onInit() {
    super.onInit();
    loadNotices();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

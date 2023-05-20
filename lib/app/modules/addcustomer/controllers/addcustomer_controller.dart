import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/components/connection_checker.dart';

import '../../../api/repository/repository.dart';
import '../../../api/service/prefrences.dart';

class AddcustomerController extends GetxController {
  RxBool isActive = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController distributor_name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController bin_no = TextEditingController();
  TextEditingController present_address = TextEditingController();
  TextEditingController disburse_address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController national_id = TextEditingController();
  TextEditingController remark_id = TextEditingController();

  //--------Dropdown beat ----------//

  RxList<dynamic> beatList = <dynamic>[].obs;
  RxString dropdownBeatValue = ''.obs;
  RxList<String> beatData = <String>[''].obs;

  DropdownBeatValueUpdater(String type) {
    dropdownBeatValue.value = type;
    Update();
    Pref.writeData(key: Pref.BEAT_NAME, value: type);
  }

  initvalues() async {
    if (await IEchecker.checker()) {
      await requestBeatList();
      await assignBeatData();
    } else {
      beatList.value = Pref.readData(key: Pref.BEATLIST) ?? [];
      await assignBeatData();
    }
  }

  RxBool isBeatLoading = false.obs;
  requestBeatList() async {
    isBeatLoading.value = true;

    Update();

    try {
      final value = await Repository().requestBeatList();
      if (value != null && value['value'] != []) {
        beatList.clear();
        beatList.value = value['value'];
        beatList.refresh();
        Pref.writeData(key: Pref.BEATLIST, value: beatList.value);
      }
      isBeatLoading.value = false;
      Update();
    } on Exception catch (e) {
      isBeatLoading.value = false;
      Update();
    }
  }

  assignBeatData() {
    if (beatList.isNotEmpty) {
      beatData.clear();
      beatList.forEach((element) {
        beatData.add(element['BEAT_NAME']);
      });
      beatData.refresh();
      Update();

      DropdownBeatValueUpdater(beatData[0]);
    }
  }
  //--------Dropdown customer type ----------//

  RxString dropdownCustomerValue = 'Regular'.obs;
  RxList<String> customerData = <String>['Regular', 'Irregular'].obs;

  DropdownCustomerValueUpdater(String type) {
    dropdownCustomerValue.value = type;
    Update();
  }

  @override
  void onInit() {
    super.onInit();
    initvalues();
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

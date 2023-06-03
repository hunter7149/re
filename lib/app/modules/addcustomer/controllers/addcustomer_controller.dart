import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:sales/app/components/connection_checker.dart';
import 'package:sales/app/components/thana_finder.dart';

import '../../../api/repository/repository.dart';
import '../../../api/service/prefrences.dart';
import '../../../config/app_themes.dart';

class AddcustomerController extends GetxController {
  RxBool isCustomerTypeLoading = false.obs;
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
  TextEditingController current_balance = TextEditingController();
  TextEditingController credit_limit = TextEditingController();

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
    print("${BANGLADESHGEOCODE.returnThana(districtName: "Dhaka")}");
    if (await IEchecker.checker()) {
      await requestBeatList();
      await assignBeatData();
      Division.clear();
      Division.value =
          BANGLADESHGEOCODE.returnDivision(countryName: 'Bangladesh');
      Division.refresh();
      dropdownDivisionValue.value = Division.isEmpty ? '' : Division[0];
    } else {
      Division.clear();
      Division.value =
          BANGLADESHGEOCODE.returnDivision(countryName: 'Bangladesh');
      Division.refresh();
      dropdownDivisionValue.value = Division.isEmpty ? '' : Division[0];
      beatList.value = Pref.readData(key: Pref.BEATLIST) ?? [];
      offlineDropDowns();
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
      } else {
        offlineDropDowns();
      }
      isBeatLoading.value = false;
      Update();
    } on Exception {
      offlineDropDowns();
      isBeatLoading.value = false;
      Update();
    }
  }

  offlineDropDowns() {
    beatList.value = Pref.readData(key: Pref.BEATLIST) ?? [];

    assignBeatData();
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

  //------------------Dropdown country------------------/

  RxString dropdownCountryValue = 'Bangladesh'.obs;
  RxList<String> Country = <String>['Bangladesh'].obs;
  DropdownCountryValueUpdater(String type) {
    dropdownCountryValue.value = type;
    Division.clear();
    Division.value = BANGLADESHGEOCODE.returnDivision(countryName: type);
    Division.refresh();
    dropdownDivisionValue.value = Division.isEmpty ? '' : Division[0];
    Update();
  }

  //---Division setter---//

  RxString dropdownDivisionValue = ''.obs;
  RxList<String> Division = <String>[''].obs;

  DropdownDivisionValueUpdater(String type) {
    dropdownDivisionValue.value = type;
    District.clear();
    District.value = BANGLADESHGEOCODE.returnDistrict(divisionName: type);
    District.refresh();
    dropdownDistrictValue.value = District.isEmpty ? '' : District[0];
    Update();
  }

  //----District setter---//
  RxString dropdownDistrictValue = ''.obs;
  RxList<String> District = <String>[''].obs;

  DropdownDistrictValueUpdater(String type) {
    dropdownDistrictValue.value = type;
    Thana.clear();
    Thana.value = BANGLADESHGEOCODE.returnThana(districtName: type);
    Thana.refresh();
    dropdownThanaValue.value = Thana.isEmpty ? '' : Thana[0];
    Update();
  }

  //---Thana list ----//
  RxString dropdownThanaValue = ''.obs;
  RxList<String> Thana = <String>[''].obs;

  DropdownThanaValueUpdater(String type) {
    dropdownThanaValue.value = type;
    Update();
  }

  //--------Image file---------//
  final file = Rxn<XFile>();
  setFile(XFile? f) {
    file.value = f;
    Update();
  }

  List<String> findEmptyFields() {
    List<String> emptyFields = [];

    // Check text editing controllers
    if (name.text.isEmpty) {
      emptyFields.add('Name');
    }
    if (distributor_name.text.isEmpty) {
      emptyFields.add('Distributor Name');
    }
    if (code.text.isEmpty) {
      emptyFields.add('Code');
    }
    if (bin_no.text.isEmpty) {
      emptyFields.add('Bin No');
    }
    if (present_address.text.isEmpty) {
      emptyFields.add('Present Address');
    }
    if (phone.text.isEmpty) {
      emptyFields.add('Phone');
    }
    if (credit_limit.text.isEmpty) {
      emptyFields.add('Credit Limit');
    }

    // Check dropdown values
    if (dropdownBeatValue.isEmpty) {
      emptyFields.add('Beat');
    }
    if (dropdownCustomerValue.isEmpty) {
      emptyFields.add('Customer Type');
    }
    if (dropdownCountryValue.isEmpty) {
      emptyFields.add('Country');
    }
    if (dropdownDivisionValue.isEmpty) {
      emptyFields.add('Division');
    }
    if (dropdownDistrictValue.isEmpty) {
      emptyFields.add('District');
    }
    if (dropdownThanaValue.isEmpty) {
      emptyFields.add('Thana');
    }

    return emptyFields;
  }

  RxBool isError = false.obs;
  RxList<String> emptyFields = <String>[].obs;
  void validateForm() {
    emptyFields.value = findEmptyFields();
    emptyFields.refresh();

    if (emptyFields.isEmpty) {
      isError.value = false;
      Update();
      print("Form is valid");
      QuickAlert.show(
          context: Get.context!,
          confirmBtnColor: AppThemes.modernGreen,
          type: QuickAlertType.success,
          onConfirmBtnTap: () {
            Get.back();
            Get.back();
          });
    } else {
      isError.value = true;
      Update();

      String errorMessage =
          'The following fields are empty: ${emptyFields.join(', ')}';
      print(errorMessage);
    }
  }

  RxBool isLocal = false.obs;
  final profileImage = Rxn<XFile>();
  RxString networkImage = ''.obs;
  setImageFile(XFile f) {
    isLocal.value = true;
    profileImage.value = f;
    Update();
  }

  @override
  void onInit() {
    super.onInit();
    initvalues();
    // validateForm();
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

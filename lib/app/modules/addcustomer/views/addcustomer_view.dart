import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/components/image_picker.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/addcustomer_controller.dart';

class AddcustomerView extends GetView<AddcustomerController> {
  const AddcustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: COMMONWIDGET.globalAppBar(
            tittle: "Add customer",
            backFunction: () {
              Get.back();
            }),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 60,
                child: Column(
                  children: [
                    Obx(() => controller.isError.value
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            // height: 50,
                            decoration:
                                BoxDecoration(color: AppThemes.modernRed),
                            child: Center(
                              child: Text(
                                'The following fields are empty: ${controller.emptyFields.join(', ')}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        : Container()),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.distributor_name,
                                  labelText: "Distributor",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => controller.isBeatLoading.value
                                    ? SpinKitRipple(
                                        color: AppThemes.modernGreen,
                                      )
                                    : Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            // color: Colors.blueGrey.shade200,
                                            border: Border.all(
                                                width: 1,
                                                color: AppThemes.modernGreen),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 5),
                                        // margin: EdgeInsets.only(top: 10),
                                        width: double.maxFinite,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            alignment: Alignment.center,
                                            value: controller
                                                .dropdownBeatValue.value,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey.shade700,
                                            ),
                                            elevation: 2,
                                            style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontWeight: FontWeight.w400),
                                            onChanged: (String? newValue) {
                                              controller
                                                  .DropdownBeatValueUpdater(
                                                      newValue!);
                                            },
                                            items: controller.beatData.value
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(height: 20),
                              commonTextField(
                                  controller: controller.code,
                                  labelText: "Code",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => controller.isCustomerTypeLoading.value
                                    ? SpinKitRipple(
                                        color: AppThemes.modernGreen,
                                      )
                                    : Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            // color: Colors.blueGrey.shade200,
                                            border: Border.all(
                                                width: 1,
                                                color: AppThemes.modernGreen),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 5),
                                        // margin: EdgeInsets.only(top: 10),
                                        width: double.maxFinite,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            alignment: Alignment.center,
                                            value: controller
                                                .dropdownCustomerValue.value,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey.shade700,
                                            ),
                                            elevation: 2,
                                            style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontWeight: FontWeight.w400),
                                            onChanged: (String? newValue) {
                                              controller
                                                  .DropdownCustomerValueUpdater(
                                                      newValue!);
                                            },
                                            items: controller.customerData.value
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.name,
                                  labelText: "Name",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.bin_no,
                                  labelText: "Bin no",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.present_address,
                                  labelText: "Present address",
                                  maxLine: 4,
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              //--Country dropdown--//
                              Obx(
                                () => controller.Country.isEmpty
                                    ? Container()
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Country:",
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  // color: Colors.blueGrey.shade200,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppThemes
                                                          .modernGreen),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 5),
                                              // margin: EdgeInsets.only(top: 10),
                                              width: double.maxFinite,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  alignment: Alignment.center,
                                                  value: controller
                                                      .dropdownCountryValue
                                                      .value,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  elevation: 2,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onChanged:
                                                      (String? newValue) {
                                                    controller
                                                        .DropdownCountryValueUpdater(
                                                            newValue!);
                                                  },
                                                  items: controller
                                                      .Country.value
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              //--Division dropdown--//
                              Obx(
                                () => controller.Division[0] == ''
                                    ? Container()
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Division:",
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  // color: Colors.blueGrey.shade200,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppThemes
                                                          .modernGreen),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 5),
                                              // margin: EdgeInsets.only(top: 10),
                                              width: double.maxFinite,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  alignment: Alignment.center,
                                                  value: controller
                                                      .dropdownDivisionValue
                                                      .value,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  elevation: 2,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onChanged:
                                                      (String? newValue) {
                                                    controller
                                                        .DropdownDivisionValueUpdater(
                                                            newValue!);
                                                  },
                                                  items: controller
                                                      .Division.value
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              //--District dropdown--//

                              Obx(
                                () => controller.District[0] == ''
                                    ? Container()
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "District:",
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  // color: Colors.blueGrey.shade200,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppThemes
                                                          .modernGreen),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 5),
                                              // margin: EdgeInsets.only(top: 10),
                                              width: double.maxFinite,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  alignment: Alignment.center,
                                                  value: controller
                                                      .dropdownDistrictValue
                                                      .value,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  elevation: 2,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onChanged:
                                                      (String? newValue) {
                                                    controller
                                                        .DropdownDistrictValueUpdater(
                                                            newValue!);
                                                  },
                                                  items: controller
                                                      .District.value
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              //--Thana dropdown--//
                              Obx(
                                () => controller.Thana[0] == ''
                                    ? Container()
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Police Station:",
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  // color: Colors.blueGrey.shade200,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppThemes
                                                          .modernGreen),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 5),
                                              // margin: EdgeInsets.only(top: 10),
                                              width: double.maxFinite,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  alignment: Alignment.center,
                                                  value: controller
                                                      .dropdownThanaValue.value,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  elevation: 2,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onChanged:
                                                      (String? newValue) {
                                                    controller
                                                        .DropdownThanaValueUpdater(
                                                            newValue!);
                                                  },
                                                  items: controller.Thana.value
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),

                              commonTextField(
                                  controller: controller.disburse_address,
                                  labelText: "Disburse address",
                                  maxLine: 4,
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.phone,
                                  labelText: "Phone",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Photograph",
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: ZoomTapAnimation(
                                        onTap: () {
                                          ImageAlert(
                                                  controller: controller,
                                                  context: context)
                                              .show();
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: AppThemes.modernGreen
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // border: Border.all(
                                            //     width: 1,
                                            //     color: AppThemes.modernGreen)
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Select photo",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.national_id,
                                  labelText: "National ID",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  controller: controller.remark_id,
                                  labelText: "Remark ID",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  inputType: TextInputType.number,
                                  controller: controller.current_balance,
                                  labelText: "Current balance",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                              commonTextField(
                                  inputType: TextInputType.number,
                                  controller: controller.credit_limit,
                                  labelText: "Credit limit",
                                  onChanged: () {}),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: ZoomTapAnimation(
                    onTap: () {
                      controller.validateForm();
                      // Get.back();
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(color: AppThemes.modernGreen),
                      child: Center(
                        child: Text(
                          "Add customer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  static commonTextField(
      {required TextEditingController controller,
      VoidCallback? onChanged,
      required String labelText,
      TextInputType? inputType,
      int? maxLine}) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        onChanged;
      },
      keyboardType: inputType ?? TextInputType.text,
      maxLines: maxLine ?? 1,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.center,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 14.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppThemes.modernGreen,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppThemes.modernCoral,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';

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
                                    width: 1, color: AppThemes.modernGreen),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            // margin: EdgeInsets.only(top: 10),
                            width: double.maxFinite,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                alignment: Alignment.center,
                                value: controller.dropdownBeatValue.value,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey.shade700,
                                ),
                                elevation: 2,
                                style: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w400),
                                onChanged: (String? newValue) {
                                  controller.DropdownBeatValueUpdater(
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
                    () => controller.isBeatLoading.value
                        ? SpinKitRipple(
                            color: AppThemes.modernGreen,
                          )
                        : Container(
                            height: 50,
                            decoration: BoxDecoration(
                                // color: Colors.blueGrey.shade200,
                                border: Border.all(
                                    width: 1, color: AppThemes.modernGreen),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            // margin: EdgeInsets.only(top: 10),
                            width: double.maxFinite,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                alignment: Alignment.center,
                                value: controller.dropdownCustomerValue.value,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey.shade700,
                                ),
                                elevation: 2,
                                style: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w400),
                                onChanged: (String? newValue) {
                                  controller.DropdownCustomerValueUpdater(
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
                  )
                ],
              ),
            ),
          ),
        ));
  }

  static commonTextField(
      {required TextEditingController controller,
      VoidCallback? onChanged,
      required String labelText,
      int? maxLine}) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        onChanged;
      },
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

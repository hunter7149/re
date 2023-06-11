import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../api/repository/repository.dart';
import '../../../api/service/prefrences.dart';
import '../../../components/connection_checker.dart';
import '../../../config/app_themes.dart';
import '../../../routes/app_pages.dart';
import '../../../sync/products/offlineproductsync.dart';

class DashboardController extends GetxController {
  RxList<dynamic> data = <dynamic>["as", "bs"].obs;
  final RxString argumentToDetailPage = RxString('you are the best!');
  final RxString argumentFromDetailPage = RxString('no argument yet');
  RxList<Map<String, dynamic>> urls = <Map<String, dynamic>>[
    {
      "thumb":
          "https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Serum-2.jpg",
      "link":
          "https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Serum-2.jpg",
      "type": 0
    },
    // {
    //   "thumb":
    //       "https://www.kablewala.com.bd/images/detailed/285/cfd1e87276e96026dd0a8730df47221b.jpg",
    //   "link":
    //       "https://www.appsloveworld.com/wp-content/uploads/2018/10/640.mp4",
    //   "type": 1
    // },
    {
      "thumb":
          "https://www.kablewala.com.bd/images/detailed/285/cfd1e87276e96026dd0a8730df47221b.jpg",
      "link": "https://www.youtube.com/watch?v=qx6xsMA6Si4&ab_channel=NIORBD",
      "type": 1
    },
    {
      "thumb":
          "https://i0.wp.com/www.pinkflashbd.com/wp-content/uploads/2023/02/Nior-Matte-Lipstick-Pencil-10.jpg",
      "link": "https://www.youtube.com/watch?v=78-RWURXBQM&ab_channel=NIORBD",
      "type": 1
    },
    {
      "thumb":
          "https://nior.com/wp-content/uploads/elementor/thumbs/1920x-645-1-q5a0om4ufcsk62isizpw39ri6mc711xgk55nwnjn8w.png",
      "link":
          "https://www.appsloveworld.com/wp-content/uploads/2018/10/640.mp4",
      "type": 1
    },
  ].obs;
  argumentUpdater({required double result}) {
    argumentFromDetailPage.value = result.toStringAsFixed(0);
    update();
  }

  // Future goToDetailPage(var index) async {
  //   var result;
  //   if (index == 0) {
  //     Get.toNamed(Routes.ORDERHOME, id: Constants.nestedNavigationNavigatorId);
  //   } else if (index == 1) {
  //     result = await Get.toNamed(Routes.PRODUCT,
  //         arguments: argumentToDetailPage.value,
  //         id: Constants.nestedNavigationNavigatorId);
  //     argumentFromDetailPage.value = result == null
  //         ? 'No argument'
  //         : (result as double).toStringAsFixed(0);
  //   } else {
  //     print('button $index');
  //   }
  // }
  //--------------------------------Beat Customer select----------------------//

  RxBool isBeatCustomerSelected = false.obs;
  beatCustomerSelectedUpdater({required bool status}) {
    isBeatCustomerSelected.value = status;
    update();
  }

  TextEditingController searchCustomerController = TextEditingController();
  RxString dropdownBeatValue = 'Select beat'.obs;
  RxList<String> beatData = <String>['Select beat'].obs;

  DropdownBeatValueUpdater(String type) {
    dropdownBeatValue.value = type;
    update();
    Pref.writeData(key: Pref.BEAT_NAME, value: type);
    customiseCustomerList(beatName: type);
  }

  RxString selectedCustomerId = ''.obs;
  RxString dropdownCustomerValue = 'Select Customer'.obs;
  RxList<String> customerData = <String>['Select Customer'].obs;

  DropdownCustomerValueUpdater(String type) {
    dropdownCustomerValue.value = type;
    update();
    Pref.writeData(key: Pref.CUSTOMER_NAME, value: type);
    final selectedCustomer = customerList.firstWhere(
      (customer) => customer['ID'].toString() == type.toString().split(" ~")[1],
      orElse: () => {},
    );
    if (selectedCustomer != null) {
      selectedCustomerId.value = selectedCustomer['ID'].toString();
      Pref.writeData(key: Pref.CUSTOMER_CODE, value: selectedCustomerId.value);
      print(selectedCustomerId.value);
    }
  }

  RxBool isBeatLoading = false.obs;
  RxBool isCustomerLoading = false.obs;
  RxList<dynamic> beatList = <dynamic>[].obs;
  RxList<dynamic> customerList = <dynamic>[].obs;
  List<String> filteredCustomers = [];

  void UpdateFilteredCustomers(String query) {
    if (query.isEmpty) {
      customiseCustomerList(beatName: dropdownBeatValue.value);
    } else {
      List<String> filteredResults = customerList
          .where((customer) => customer['CUSTOMER_NAME']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map<String>(
              (customer) => "${customer['CUSTOMER_NAME']} ~${customer['ID']}")
          .toList();
      customerData.clear();

      if (filteredResults.isEmpty) {
        customerData.add('No results found');
        DropdownCustomerValueUpdater('No results found');
      } else {
        DropdownCustomerValueUpdater(filteredResults.first);
        customerData.addAll(filteredResults);
      }
    }
  }

  customiseCustomerList({required String beatName}) {
    final selectedBeat = beatList.firstWhere(
      (beat) => beat['BEAT_NAME'] == beatName,
      orElse: () => {},
    );
    if (selectedBeat != null) {
      final selectedBeatId = selectedBeat['ID'];
      final filteredCustomers = customerList
          .where((customer) => customer['BEAT_ID'] == selectedBeatId.toString())
          .toList();
      if (filteredCustomers.isNotEmpty) {
        customerData.assignAll(filteredCustomers.map<String>(
            (customer) => "${customer['CUSTOMER_NAME']} ~${customer['ID']}"));
        selectedCustomerId.value = filteredCustomers[0]['ID'].toString();
        DropdownCustomerValueUpdater(
            customerData.isNotEmpty ? customerData.first : 'Select Customer');
      } else {
        customerData.clear();
        customerData.add('No customer');
        DropdownCustomerValueUpdater('No customer');
      }
    } else {
      customerData.clear();
      customerData.add('No customer');
      DropdownCustomerValueUpdater('No customer');
    }
  }

  initialDropdownValue() async {
    if (await IEchecker.checker()) {
      await requestBeatList();
      await requestCustomerList();
      assignBeatData();
      assignCustomerData();
    } else {
      offlineDropDowns();
    }
  }

  offlineDropDowns() {
    beatList.value = Pref.readData(key: Pref.BEATLIST) ?? [];
    customerList.value = Pref.readData(key: Pref.CUSTOMERLIST) ?? [];
    assignBeatData();
    assignCustomerData();
  }

  requestBeatList() async {
    isBeatLoading.value = true;
    update();
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
      update();
    } on Exception {
      offlineDropDowns();
      isBeatLoading.value = true;
      update();
    }
  }

  requestCustomerList() async {
    isCustomerLoading.value = true;
    update();
    try {
      final value = await Repository().requestCustomerList();
      if (value != null && value['value'] != []) {
        customerList.clear();
        customerList.value = value['value'];
        customerList.refresh();
        Pref.writeData(key: Pref.CUSTOMERLIST, value: customerList.value);
      } else {
        offlineDropDowns();
      }
      isCustomerLoading.value = false;
      update();
    } on Exception {
      offlineDropDowns();
      isCustomerLoading.value = false;
      update();
    }
  }

  setBeatCustomer() async {
    Pref.writeData(key: Pref.BEAT_NAME, value: dropdownBeatValue.value);
    Pref.writeData(key: Pref.CUSTOMER_NAME, value: dropdownCustomerValue.value);
    Pref.writeData(key: Pref.CUSTOMER_CODE, value: selectedCustomerId.value);
    beatCustomerSelectedUpdater(status: true);
    String beatName = Pref.readData(key: Pref.BEAT_NAME) ?? '';
    String CustomerName = Pref.readData(key: Pref.CUSTOMER_NAME) ?? '';
    String customerCode = Pref.readData(key: Pref.CUSTOMER_CODE) ?? '';
    await firebaseStore();
    update();
  }

  firebaseStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference stringsCollection = firestore.collection('fcm_token');
    try {
      await stringsCollection.doc("${Pref.readData(key: Pref.USER_ID)}").set({
        'device': Pref.readData(key: Pref.DEVICE_IDENTITY).toString(),
        'token': Pref.readData(key: Pref.FCM_TOKEN).toString(),
        'userId': "${Pref.readData(key: Pref.USER_ID)}"
      });
      print('String uploaded successfully');
    } catch (e) {
      print('Error uploading string: $e');
    }
  }

  assignBeatData() {
    if (beatList.isNotEmpty) {
      beatData.clear();
      beatList.forEach((element) {
        beatData.add(element['BEAT_NAME']);
      });
      beatData.refresh();
      isBeatLoading.value = false;
      update();
      DropdownBeatValueUpdater(beatData[0]);
    } else {
      beatData.value = [];
      dropdownBeatValue.value = '';
      isBeatLoading.value = false;
      update();
    }
  }

  assignCustomerData() {
    if (customerList.isNotEmpty) {
      customerData.clear();
      customerList.forEach((element) {
        customerData.add("${element['CUSTOMER_NAME']} ~${element['ID']}");
      });
      customerData.refresh();
      isCustomerLoading.value = false;
      update();
      customiseCustomerList(beatName: beatData[0]);
      // DropdownCustomerValueUpdater(customerData[0]);
    } else {
      customerData.value = [];
      dropdownCustomerValue.value = '';
      isCustomerLoading.value = false;
      update();
    }
  }

  beatSelection() {
    Get.generalDialog(
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4 * anim1.value,
                sigmaY: 4 * anim1.value,
              ),
              child: FadeTransition(
                child: child,
                opacity: anim1,
              ),
            ),
        pageBuilder: (ctx, anim1, anim2) {
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Beat selection",
                    style: TextStyle(),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     child: Center(
                  //         child: Icon(
                  //       Icons.close,
                  //       color: Colors.red.shade800,
                  //       size: 20,
                  //     )),
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey.shade200,
                  //         borderRadius: BorderRadius.circular(100)),
                  //   ),
                  // )
                ],
              ),
              content: Container(
                // height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return isBeatLoading.value
                            ? SpinKitThreeBounce(
                                color: AppThemes.modernBlue,
                              )
                            : beatData.isEmpty
                                ? Container()
                                : Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        // color: Colors.blueGrey.shade200,
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade500),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 5),
                                    margin: EdgeInsets.only(top: 10),
                                    width: double.maxFinite,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        alignment: Alignment.center,
                                        value: dropdownBeatValue.value,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey.shade700,
                                        ),
                                        elevation: 2,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w300),
                                        onChanged: (String? newValue) {
                                          DropdownBeatValueUpdater(newValue!);
                                        },
                                        items: beatData.value
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return isCustomerLoading.value
                            ? Container(
                                height: 30,
                                child: SpinKitThreeBounce(
                                  color: AppThemes.modernBlue,
                                ),
                              )
                            : customerData.isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade500),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 5),
                                    margin: EdgeInsets.only(top: 10),
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller: searchCustomerController,
                                          onChanged: (value) {
                                            Future.delayed(
                                                    Duration(milliseconds: 0))
                                                .then((v) {
                                              UpdateFilteredCustomers(value);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Search Customer',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: dropdownCustomerValue.value,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey.shade700,
                                            ),
                                            elevation: 2,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            onChanged: (String? newValue) {
                                              DropdownCustomerValueUpdater(
                                                  newValue!);
                                            },
                                            items: customerData
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                      }),
                    ],
                  ),
                ),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    Get.closeCurrentSnackbar();
                    Get.back();
                    // controller.requestCheckout();
                    setBeatCustomer();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppThemes.modernGreen,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text("Okay", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await initialDropdownValue();
    beatSelection();

    // OFFLINEPRODUCTSYNC().offlineDataSync(brands: [
    //   'acnol',
    //   'blazoskin',
    //   'elanvenezia',
    //   'tylox',
    //   'herlan',
    //   'lily',
    //   'nior',
    //   'orix',
    //   'siodil',
    //   'sunbit',
    // ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

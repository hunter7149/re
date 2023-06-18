import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../api/firebase/pushnotificationservice.dart';
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
  RxString selectedCustomerPriceId = ''.obs;
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
      selectedCustomerPriceId.value = selectedCustomer['PRICE_ID'].toString();
      selectedCustomerId.value = selectedCustomer['ID'].toString();
      Pref.writeData(key: Pref.CUSTOMER_CODE, value: selectedCustomerId.value);
      Pref.writeData(
          key: Pref.OFFLINE_PRICE_ID, value: selectedCustomerPriceId.value);
      setPrice(priceId: selectedCustomerPriceId.value);
      print(selectedCustomerId.value);
      print(selectedCustomerPriceId.value);
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
    Pref.writeData(
        key: Pref.OFFLINE_PRICE_ID, value: selectedCustomerPriceId.value);
    beatCustomerSelectedUpdater(status: true);
    String beatName = Pref.readData(key: Pref.BEAT_NAME) ?? '';
    String CustomerName = Pref.readData(key: Pref.CUSTOMER_NAME) ?? '';
    String customerCode = Pref.readData(key: Pref.CUSTOMER_CODE) ?? '';

    await firebaseStore();
    _checkVersion();
    update();
  }

  firebaseStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference stringsCollection = firestore.collection('fcm_token');

    DocumentReference documentRef =
        firestore.collection('fcm_token').doc("latest_version");
    DocumentSnapshot<Object?> snapshot = await documentRef.get();
    dynamic tempVer = snapshot.data();
    latestVersion.value = tempVer?['verson'] ?? '';
    isForce.value = tempVer?['force'] ?? false;
    updateMessage.value = tempVer?['message'] ?? "";
    update();
    print(snapshot.data());
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
                    Get.closeAllSnackbars();
                    Get.back();
                    // controller.requestCheckout();
                    setBeatCustomer();
                    // _checkVersion();
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

  //------------------Code for version check---------------------//
  PackageInfo? _packageInfo;
  RxString latestVersion = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isForce = false.obs;
  RxString updateMessage = ''.obs;

  Future<void> _checkVersion() async {
    isLoading.value = true;
    update();

    try {
      // Retrieve the current installed version
      final packageInfo = await PackageInfo.fromPlatform();
      _packageInfo = packageInfo;

      // Retrieve the latest version from Google Play Store
      final url = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.remark.sales');
      // if (await canLaunchUrl(url)) {
      //   await launchUrl(
      //     url,
      //   );
      // }

      // Compare the versions

      if (_packageInfo != null && latestVersion.value != '') {
        final installedVersion = _packageInfo!.version;

        final isNewVersionAvailable =
            latestVersion.value.compareTo(installedVersion) > 0;

        if (isNewVersionAvailable) {
          // Prompt the user to update
          updateAlert(
              message: updateMessage.value,
              version: latestVersion.value,
              force: isForce.value);
        }
      }
    } catch (e) {
      isLoading.value = false;
      update();
      print('Failed to check version: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  //  onPressed: () async {
  //               // Open the app page in Google Play Store
  //               final storeUrl = Uri.parse(
  //                   'https://play.google.com/store/apps/details?id=com.remark.attendance');
  //               if (await canLaunchUrl(storeUrl)) {
  //                 await launchUrl(storeUrl);
  //               }
  //             },

  static updateAlert(
      {required String message, required String version, required bool force}) {
    return Get.generalDialog(
        barrierDismissible: false,
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
        pageBuilder: (ctx, anim1, anim2) => MediaQuery(
              data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
              child: WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Update available",
                        style: TextStyle(),
                      ),
                      force
                          ? Container()
                          : InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                    child: Icon(
                                  Icons.close,
                                  color: Colors.red.shade800,
                                  size: 20,
                                )),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )
                    ],
                  ),
                  content: Container(
                      // height: 300,
                      width: double.maxFinite,
                      child: Text("${message}",
                          style: TextStyle(color: Colors.black))),
                  actionsPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                            child: ZoomTapAnimation(
                          onTap: () async {
                            final storeUrl = Uri.parse(
                                'https://play.google.com/store/apps/details?id=com.remark.sales');
                            if (await canLaunchUrl(storeUrl)) {
                              await launchUrl(storeUrl);
                            }
                          },
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppThemes.modernGreen,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text("Update",
                                  style: TextStyle(color: Colors.white))),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  setPrice({required String priceId}) {
    // dynamic firstData = Pref.readData(key: Pref.OFFLINE_DATA);
    dynamic secondData = Pref.readData(key: Pref.OFFLINE_PRICE);
    // print(firstData);
    List<dynamic> matchingElements = secondData['value']
        .where((element) => element['PRICE_TYPE_ID'].toString() == priceId)
        .toList();

    // // Iterate through the first JSON data
    // firstData.forEach((brand, categories) {
    //   categories.forEach((category, products) {
    //     for (var product in products) {
    //       // Get the PRODUCT_CODE of the product
    //       String productCode = product['PRODUCT_CODE'];

    //       // Check if the PRODUCT_CODE exists in the matching elements
    //       var matchingProduct = matchingElements.firstWhere(
    //         (element) => element['SKU_CODE'] == product['PRODUCT_CODE'],
    //         orElse: () => null,
    //       );

    //       if (matchingProduct != null) {
    //         // Store the old and new values
    //         var oldMRP = product['MPR'];
    //         var newMRP = matchingProduct['SELL_VALUE'];

    //         // Replace MPR with SELL_VALUE
    //         product['MPR'] = newMRP;

    //         // Print the old and new values if they have been exchanged
    //         if (oldMRP != newMRP) {
    //           print('SKU: ${product['SKU_CODE']}');
    //           print('Old MRP: $oldMRP');
    //           print('New MRP: $newMRP');
    //         }
    //       }
    //     }
    //   });
    // });
    // print(firstData);
    Pref.writeData(key: Pref.OFFLINE_CUSTOMIZED_DATA, value: matchingElements);
    print(Pref.readData(key: Pref.OFFLINE_CUSTOMIZED_DATA));
  }

  requestPrice() async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        await Repository().requestPriceList().then((value) {
          print(value);
          Pref.writeData(key: Pref.OFFLINE_PRICE, value: value);
        });
      } on Exception catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await requestPrice();
    await initialDropdownValue();

    beatSelection();

    OFFLINEPRODUCTSYNC().offlineDataSync(brands: [
      'acnol',
      'blazoskin',
      'elanvenezia',
      'tylox',
      'herlan',
      'lily',
      'nior',
      'orix',
      'siodil',
      'sunbit',
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

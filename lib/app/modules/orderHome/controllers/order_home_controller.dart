import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/DAO/cartitemdao.dart';
import 'package:sales/app/api/repository/repository.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/models/cartproduct.dart';

import '../../../DAO/offlineOrderDao.dart';
import '../../../DAO/orderItemDao.dart';
import '../../../DAO/saleRequisitionDao.dart';
import '../../../api/service/prefrences.dart';
import '../../../components/cart_value.dart';
import '../../../components/connection_checker.dart';
import '../../../database/database.dart';
import '../../../models/orderItem.dart';
import '../../../models/saleRequisition.dart';

class OrderHomeController extends GetxController {
  final count = 0.0.obs;
  RxString savedBeatName = ''.obs;
  RxString savedCustomerName = ''.obs;
  RxString savedSelectedCustomerId = ''.obs;
  List<Color> randomeColor = [
    AppThemes.modernBlue,
    AppThemes.modernGreen,
    AppThemes.modernPurple,
    AppThemes.modernRed,
    AppThemes.modernCoolPink
  ];
  RxList<Map<String, dynamic>> bottomMenu = <Map<String, dynamic>>[
    {
      "title": "Cosmetic and Beauty",
      "icon": "assets/images/makeup-pouch.png",
      "key": "cosmetic"
    },
    {
      "title": "Hygiene",
      "icon": "assets/images/skincare.png",
      "key": "hygiene"
    },
    {
      "title": "Home Care",
      "icon": "assets/images/hygiene.png",
      "key": "homecare"
    },
  ].obs;

  //-------------------------Beat Dropdown menu--------------------//
  TextEditingController searchCustomerController = TextEditingController();
  RxString dropdownBeatValue = ''.obs;
  RxList<String> beatData = <String>[''].obs;

  DropdownBeatValueUpdater(String type) {
    dropdownBeatValue.value = type;
    Update();
    Pref.writeData(key: Pref.BEAT_NAME, value: type);
    customiseCustomerList(beatName: type);
  }

  RxString selectedCustomerId = ''.obs;
  RxString dropdownCustomerValue = ''.obs;
  RxList<String> customerData = <String>[''].obs;

  DropdownCustomerValueUpdater(String type) {
    dropdownCustomerValue.value = type;
    Update();
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
    setIfSaved();
    // readBeatCustomerStatus();
  }

  offlineDropDowns() {
    beatList.value = Pref.readData(key: Pref.BEATLIST) ?? [];
    customerList.value = Pref.readData(key: Pref.CUSTOMERLIST) ?? [];
    assignBeatData();
    assignCustomerData();
  }

  requestBeatList() async {
    isBeatLoading.value = true;
    isCustomerLoading.value = true;
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

  requestCustomerList() async {
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
      Update();
    } on Exception {
      isCustomerLoading.value = false;
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

      DropdownBeatValueUpdater(beatData[0]);
    } else {
      beatData.value = [];
      dropdownBeatValue.value = '';
      isBeatLoading.value = false;
      Update();
    }
  }

  assignCustomerData() {
    if (customerList.isNotEmpty) {
      customerData.clear();
      customerList.forEach((element) {
        customerData.add("${element['CUSTOMER_NAME']} ~${element['ID']}");
      });
      customerData.refresh();

      customiseCustomerList(beatName: beatData[0]);
      isCustomerLoading.value = false;
      Update();
      // DropdownCustomerValueUpdater(customerData[0]);
    } else {
      customerData.value = [];
      dropdownCustomerValue.value = '';
      isCustomerLoading.value = false;
      Update();
    }
  }

  RxBool isReorder = false.obs;
  RxBool isReorderCompleted = false.obs;
  RxList<Map<String, dynamic>> previousOrder = <Map<String, dynamic>>[].obs;
  addAllToCart() async {
    // final tempList = previousOrder[0]["products"];
    itemList.forEach((element) async {
      CartItem item = CartItem(
          userId: "${Pref.readData(key: Pref.USER_ID)}",
          productId: element.productId,
          beatName: dropdownBeatValue.value,
          customerName: dropdownCustomerValue.value,
          productName: element.productName,
          catagory: element.catagory,
          unit: element.unit,
          image: element.image,
          price: double.tryParse(element.price.toString()) ?? 0.0,
          brand: element.brand,
          quantity: element.quantity);
      await cartItemDao.insertCartItem(item);
    });
    CartCounter.cartCounter();
    // final data = await cartItemDao.findAllCartItem() as List<CartItem>;
    print("=======================");
    // print(data);
    isReorder.value = true;
    Update();
    loadData();
    Timer(Duration(seconds: 2), () {
      isReorderCompleted.value = true;
      Update();
    });
  }

  //get value
  RxList<CartItem> cartItems = <CartItem>[].obs;
  loadData() async {
    await cartItemDao.findAllCartItem().then((value) {
      cartItems.value = value;
      print("dta length -> ${cartItems[0].beatName}");
    });
  }

  late CartItemDao cartItemDao;

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    orderItemDao = database.orderItemDao;
    saleRequisitionDao = database.saleRequisitionDao;
    offlineOrderDao = database.offlineOrderDao;
    await readBeatCustomerStatus();

    await reqOrderList();

    initialDropdownValue();

    await offlineOrderCounter();
    // setIfSaved();
  }

  RxInt offlineOrderCount = 0.obs;
  offlineOrderCounter() async {
    await offlineOrderDao.findAllOfflineOrder().then((value) {
      List<dynamic> orderList = value ?? [];
      offlineOrderCount.value = orderList.length ?? 0;
      Update();
    });
  }

//----------------------------Code for previous order suggestion-------------------///
  late OrderItemDao orderItemDao;
  late SaleRequisitionDao saleRequisitionDao;
  late OfflineOrderDao offlineOrderDao;
  RxList<OrderItem> orderItem = <OrderItem>[].obs;
//-----------------------Get Main Order List----------------------//
  reqOrderList() async {
    await orderItemDao.findAllOrderItem().then((value) async {
      orderItem.clear();
      orderItem.refresh();

      orderItem.value = value;
      orderItem.refresh();
      Update();
      if (orderItem.length != 0) {
        if (orderItem.length == 1) {
          await reqOrderedItemsList(orderId: orderItem[0].orderId!);
        } else {
          await reqOrderedItemsList(
              orderId: orderItem[orderItem.length - 1].orderId!);
        }
      }
      print(orderItem.length);
      Update();
    });
  }

//---------------------Get Detailed Order List------------------------//
  RxList<SaleRequisition> itemList = <SaleRequisition>[].obs;
  reqOrderedItemsList({required String orderId}) async {
    saleRequisitionDao.findAllSaleItemBySaleId(orderId, 1).then((value) {
      itemList.clear();
      itemList.refresh();
      itemList.value = value;
      itemList.refresh();
      Update();
    });
  }

  readBeatCustomerStatus() {
    String beatName = Pref.readData(key: Pref.BEAT_NAME) ?? '';
    String CustomerName = Pref.readData(key: Pref.CUSTOMER_NAME) ?? '';
    String customerCode = Pref.readData(key: Pref.CUSTOMER_CODE) ?? '';
    savedBeatName.value = beatName;
    savedCustomerName.value = CustomerName;
    savedSelectedCustomerId.value = customerCode;
    Update();
    print(
        "${beatName} ----------- ${CustomerName} ------------ ${customerCode}");
  }

  setIfSaved() {
    if (savedBeatName.value != '' &&
        savedCustomerName.value != '' &&
        savedSelectedCustomerId.value != '') {
      DropdownBeatValueUpdater(savedBeatName.value);
      DropdownCustomerValueUpdater(savedCustomerName.value);

      selectedCustomerId.value = savedSelectedCustomerId.value;

      Update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initValues();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

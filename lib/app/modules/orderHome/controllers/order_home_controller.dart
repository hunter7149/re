import 'dart:async';
import 'dart:ui';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/DAO/cartitemdao.dart';
import 'package:sales/app/api/repository/repository.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/models/cartproduct.dart';

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
  RxString dropdownBeatValue = 'Select beat'.obs;
  RxList<String> beatData = <String>['Select beat'].obs;

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
      }
      isBeatLoading.value = false;
      Update();
    } on Exception catch (e) {
      isBeatLoading.value = true;
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
      }
      isCustomerLoading.value = false;
      Update();
    } on Exception catch (e) {
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
      // DropdownCustomerValueUpdater(customerData[0]);
    }
  }

  RxBool isReorder = false.obs;
  RxBool isReorderCompleted = false.obs;
  RxList<Map<String, dynamic>> previousOrder = <Map<String, dynamic>>[].obs;
  addAllToCart() async {
    final tempList = previousOrder[0]["products"];
    itemList.forEach((element) async {
      CartItem item = CartItem(
          userId: 1,
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
    await reqOrderList();

    initialDropdownValue();
  }

//----------------------------Code for previous order suggestion-------------------///
  late OrderItemDao orderItemDao;
  late SaleRequisitionDao saleRequisitionDao;
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

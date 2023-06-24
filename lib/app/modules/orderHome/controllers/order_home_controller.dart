import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sales/app/DAO/cartitemdao.dart';
import 'package:sales/app/DAO/saveItemDao.dart';
import 'package:sales/app/api/repository/repository.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/models/cartproduct.dart';
import 'package:sales/app/models/saveItem.dart';

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
  RefreshController refreshController = RefreshController(initialRefresh: true);
  final count = 0.0.obs;
  RxString savedBeatName = ''.obs;
  RxString savedPriceId = ''.obs;
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
  RxString selectedCustomerPriceId = ''.obs;
  RxString dropdownCustomerValue = ''.obs;
  RxList<String> customerData = <String>[''].obs;

  DropdownCustomerValueUpdater(String type) async {
    dropdownCustomerValue.value = type;
    Update();
    Pref.writeData(key: Pref.CUSTOMER_NAME, value: type);
    final selectedCustomer = customerList.firstWhere(
      (customer) => customer['ID'].toString() == type.toString().split(" ~")[1],
      orElse: () => {},
    );
    if (selectedCustomer != null) {
      selectedCustomerPriceId.value = selectedCustomer['PRICE_ID'].toString();
      selectedCustomerId.value = selectedCustomer['ID'].toString();
      Pref.writeData(
          key: Pref.OFFLINE_PRICE_ID, value: selectedCustomerPriceId.value);
      setPrice(priceId: selectedCustomerPriceId.value);
      Pref.writeData(key: Pref.CUSTOMER_CODE, value: selectedCustomerId.value);
      await reqOrderList();
      await reqSaveList();
      print(selectedCustomerId.value);
      print(selectedCustomerPriceId.value);
    }
  }

  setPrice({required String priceId}) {
    // dynamic firstData = Pref.readData(key: Pref.OFFLINE_DATA);
    dynamic secondData = Pref.readData(key: Pref.OFFLINE_PRICE);
    // print(firstData);
    List<dynamic> matchingElements = secondData['value']
        .where((element) => element['PRICE_TYPE_ID'].toString() == priceId)
        .toList();

    Pref.writeData(key: Pref.OFFLINE_CUSTOMIZED_DATA, value: matchingElements);
    print(Pref.readData(key: Pref.OFFLINE_CUSTOMIZED_DATA));
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

      List<String> uniqueResults = [];
      for (var formattedCustomer in filteredResults) {
        if (!uniqueResults.contains(formattedCustomer)) {
          uniqueResults.add(formattedCustomer);
        }
      }
      filteredCustomers = uniqueResults;

      if (uniqueResults.isEmpty) {
        customerData.clear();
        customerData.add('No results found');
        customerData.refresh();
        DropdownCustomerValueUpdater('No results found');
      } else {
        customerData.clear();
        customerData.addAll(uniqueResults);
        customerData.refresh();
        DropdownCustomerValueUpdater(uniqueResults.first);
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
        customerData.clear();
        filteredCustomers.forEach((customer) {
          final formattedData =
              "${customer['CUSTOMER_NAME']} ~${customer['ID']}";
          if (!customerData.contains(formattedData)) {
            customerData.add(formattedData);
          }
        });
        customerData.refresh();

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
      await assignBeatData();
      await assignCustomerData();
    } else {
      offlineDropDowns();
    }
    setIfSaved();
    // readBeatCustomerStatus();
  }

  offlineDropDowns() {
    beatList.value = Pref.readData(key: Pref.BEATLIST) ?? [];
    customerList.value = Pref.readData(key: Pref.CUSTOMERLIST) ?? [];
    if (beatList.isNotEmpty) {
      beatData.clear();
      beatList.forEach((element) {
        beatData.add(element['BEAT_NAME']);
      });
      beatData.refresh();
      savedBeatName.value;
      DropdownBeatValueUpdater(savedBeatName.value ?? beatData[0]);
    } else {
      beatData.value = [];
      dropdownBeatValue.value = '';
      isBeatLoading.value = false;
      Update();
    }
    // if (customerList.isNotEmpty) {
    //   customerData.clear();
    //   customerList.forEach((element) {
    //     customerData.add("${element['CUSTOMER_NAME']} ~${element['ID']}");
    //   });
    //   customerData.refresh();

    //   customiseCustomerList(beatName: beatData[0]);
    //   isCustomerLoading.value = false;
    //   Update();
    //   // DropdownCustomerValueUpdater(customerData[0]);
    // } else {
    //   customerData.value = [];
    //   dropdownCustomerValue.value = '';
    //   isCustomerLoading.value = false;
    //   Update();
    // }
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
          productSku: element.productSku,
          productId: element.productId,
          beatName: element.beatName,
          customerName: element.customerId,
          productName: element.productName,
          catagory: element.catagory,
          unit: element.unit,
          image: element.image,
          price: double.tryParse(element.price.toString()) ?? 0.0,
          brand: element.brand,
          quantity: element.quantity);
      CartItem? existingItem =
          await cartItemDao.findCartItemById(item.productSku!).first;

      if (existingItem != null) {
        // If the item already exists, update its quantity
        CartItem temporaryItem = existingItem;

        existingItem.quantity = (existingItem.quantity! + item.quantity!);
        existingItem.price = (existingItem.price! + item.price!);
        existingItem.customerName = element.customerId;
        if (await cartItemDao
            .updateCartItem(existingItem)
            .then((value) => true)) {
          CartCounter.cartCounter();
        } else {}
      } else {
        await cartItemDao.insertCartItem(item);
      }
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
      print("dta length -> ${cartItems.length}");
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
    saveItemDao = database.saveItemDao;

    await readBeatCustomerStatus();

    await initialDropdownValue();

    await offlineOrderCounter();
    await reqOrderList();
    await reqSaveList();
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
  late SaveItemDao saveItemDao;
  RxList<OrderItem> orderItem = <OrderItem>[].obs;

//-----------------------Get Main Order List----------------------//
  reqOrderList() async {
    await orderItemDao.findAllOrderItem().then((value) async {
      orderItem.clear();
      orderItem.refresh();
      List<OrderItem> tempdata = value;

      tempdata.forEach((element) {
        if (element.CustomerId.toString() == selectedCustomerId.value) {
          orderItem.add(element);
        }
      });
      tempdata.clear();
      // orderItem.value = value;
      orderItem.refresh();
      Update();
      if (orderItem.length != 0) {
        if (orderItem.length == 1) {
          await reqOrderedItemsList(orderId: orderItem[0].orderId!);
        } else {
          await reqOrderedItemsList(
              orderId: orderItem[orderItem.length - 1].orderId!);
        }
      } else {
        itemList.clear();
        itemList.refresh();
      }
      print(orderItem.length);
      Update();
    });
  }

//---------------------Get Detailed Order List------------------------//
  RxList<SaleRequisition> itemList = <SaleRequisition>[].obs;
  reqOrderedItemsList({required String orderId}) async {
    saleRequisitionDao
        .findAllSaleItemBySaleId(orderId, Pref.readData(key: Pref.USER_ID))
        .then((value) {
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
    String customerPriceId = Pref.readData(key: Pref.OFFLINE_PRICE_ID) ?? '';
    savedPriceId.value = customerPriceId;
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
      selectedCustomerPriceId.value = savedPriceId.value;

      selectedCustomerId.value = savedSelectedCustomerId.value;

      Update();
    }
  }

  RxList<SaveItem> saveItem = <SaveItem>[].obs;
//-----------------------Get Main Save List----------------------//
  reqSaveList() async {
    await saveItemDao.findAllSaveItem().then((value) {
      saveItem.clear();
      saveItem.refresh();
      List<SaveItem> tempDATA = value ?? [];
      tempDATA.forEach((element) {
        if (element.CustomerId == selectedCustomerId.value) {
          saveItem.add(element);
        }
      });

      saveItem.refresh();
      print(saveItem.length);

      Update();
    });
  }

//---------------------Get Detailed Save List------------------------//
  RxList<SaleRequisition> savedItems = <SaleRequisition>[].obs;
  reqSavedItemsList({required String saveId}) async {
    await saleRequisitionDao
        .findAllSaleItemBySaleId(saveId, Pref.readData(key: Pref.USER_ID))
        .then((value) {
      savedItems.clear();

      savedItems.value = value;
      savedItems.refresh();
      Update();
    });
  }

  addAllSavedToCart() async {
    // final tempList = previousOrder[0]["products"];
    savedItems.forEach((element) async {
      CartItem item = CartItem(
          userId: "${Pref.readData(key: Pref.USER_ID)}",
          productSku: element.productSku,
          productId: element.productId,
          beatName: dropdownBeatValue.value,
          customerName: selectedCustomerId.value,
          productName: element.productName,
          catagory: element.catagory,
          unit: element.unit,
          image: element.image,
          price: double.tryParse(element.price.toString()) ?? 0.0,
          brand: element.brand,
          quantity: element.quantity);

      CartItem? existingItem =
          await cartItemDao.findCartItemById(item.productSku!).first;

      if (existingItem != null) {
        // If the item already exists, update its quantity
        CartItem temporaryItem = existingItem;

        existingItem.quantity = (existingItem.quantity! + item.quantity!);
        existingItem.price = (existingItem.price! + item.price!);

        if (await cartItemDao
            .updateCartItem(existingItem)
            .then((value) => true)) {
          CartCounter.cartCounter();
        } else {}
      } else {
        await cartItemDao.insertCartItem(item);
      }
    });
    await CartCounter.cartCounter();
    // final data = await cartItemDao.findAllCartItem() as List<CartItem>;
    print("=======================");
    await successAlert(remove: false);
    Timer(Duration(seconds: 1), () {
      Get.back();
    });
    // print(data);
  }

  removeSavedItem({required int index}) async {
    await saleRequisitionDao
        .deleteBySaveId(saveItem[index].saveId!)
        .then((value) async {
      print("{value}");
      await saveItemDao.deleteBySaveId(saveItem[index].saveId!).then((value) {
        print("Deleted saved id ${saveItem[index].saveId}");
      });
    });
    saveItem.removeAt(index);
    saveItem.refresh();
    await successAlert(remove: true);
    Timer(Duration(seconds: 1), () {
      Get.back();
    });
    Update();
  }

  successAlert({required bool remove}) async {
    Get.closeAllSnackbars();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.generalDialog(
          // transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
          //       filter: ImageFilter.blur(
          //         sigmaX: 4 * anim1.value,
          //         sigmaY: 4 * anim1.value,
          //       ),
          //       child: FadeTransition(
          //         child: child,
          //         opacity: anim1,
          //       ),
          //     ),
          pageBuilder: (ctx, anim1, anim2) {
        return MediaQuery(
          data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Image.asset("assets/images/success.png")),
                      Text(
                        remove ? "Removed" : "Added to cart!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
            ),
            actionsPadding: EdgeInsets.all(10),
            actions: [],
          ),
        );
      });
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

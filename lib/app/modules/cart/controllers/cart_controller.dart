import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:floor/floor.dart';
import 'package:location/location.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sales/app/DAO/offlineOrderDao.dart';
import 'package:sales/app/DAO/orderItemDao.dart';
import 'package:sales/app/DAO/saleRequisitionDao.dart';
import 'package:sales/app/DAO/saveItemDao.dart';
import 'package:sales/app/components/connection_checker.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/models/offlineorder.dart';
import 'package:sales/app/models/orderItem.dart';
import 'package:sales/app/models/saleRequisition.dart';
import 'package:geocoding/geocoding.dart' as gcode;
import 'package:sales/app/models/saveItem.dart';
import '../../../DAO/cartitemdao.dart';
import '../../../api/repository/repository.dart';
import '../../../api/service/prefrences.dart';
import '../../../database/database.dart';
import '../../../models/cartproduct.dart';

class CartController extends GetxController {
  late CartItemDao cartItemDao;
  late OrderItemDao orderItemDao;
  late OfflineOrderDao offlineOrderDao;
  late SaleRequisitionDao saleRequisitionDao;
  late SaveItemDao saveItemDao;
  RxBool isDeviceConnected = false.obs;
  connectionUpdater({required bool status}) {
    isDeviceConnected.value = status;
    Update();
    print(
        "Cart controller internet connection status: ${isDeviceConnected.value}");
  }

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
  }

  RxString currentCustomerCode = ''.obs;

  RxList<CartItem> cartItems = <CartItem>[].obs;
  loadData() async {
    currentCustomerCode.value = Pref.readData(key: Pref.CUSTOMER_CODE);
    Update();
    // initialDropdownValue();
    cartItems.clear();
    cartItems.refresh();
    await cartItemDao.findAllCartItem().then((value) {
      List<CartItem> tempCart = value;
      tempCart.forEach((element) {
        if (element.customerName == currentCustomerCode.value) {
          cartItems.add(element);
        }
      });
      // cartItems.value = value;

      cartItems.refresh();
      totalPriceCounter();
      print("dta length -> ${cartItems.length}");
    });
    // await getlocation();
    Update();
  }

  priceQuantiyUpdater(
      {required int index,
      required String quantity,
      required String price}) async {
    CartItem newItem = CartItem(
        id: cartItems[index].id,
        userId: "${Pref.readData(key: Pref.USER_ID)}",
        productId: cartItems[index].productId,
        beatName: cartItems[index].beatName!.toString().isEmpty
            ? ""
            : cartItems[index].beatName.toString(),
        customerName: cartItems[index].customerName!.toString().isEmpty
            ? ""
            : cartItems[index].customerName.toString(),
        productName: cartItems[index].productName,
        catagory: cartItems[index].catagory,
        unit: cartItems[index].unit,
        image: cartItems[index].image,
        price: double.tryParse(price) ?? cartItems[index].price,
        brand: cartItems[index].brand,
        quantity: int.tryParse(quantity) ?? 1);
    // cartItems.removeAt(index);
    cartItems[index] = newItem;
    cartItems.refresh();
    print(
        "${cartItems[index].userId!}+${cartItems[index].productId!}+${cartItems[index].price!}+${cartItems[index].id!}");
    // await cartItemDao
    //     .updateData(cartItems[index].userId!, cartItems[index].productId!,
    //         cartItems[index].price!, cartItems[index].id!)
    //     .then((value) {
    //   print("Updated row count->${value}");
    // });
    await cartItemDao.updateCartItem(newItem);
    // cartItems.clear();
    // cartItems.refresh();
    await cartItemDao.findAllCartItem().then((value) {
      cartItems.value = value;
      cartItems.refresh();
      totalPriceCounter();
      print("dta length -> ${cartItems.length}");
    });
    // await getlocation();
    Update();
    totalPriceCounter();
    Update();
  }

  screenRefresh() {
    cartItems.refresh();
    Update();
  }

  requestOnlineCheckout({required dynamic data}) async {
    try {
      await Repository()
          .requestSaleRequistion(body: {"data": "${data.value}"}).then((value) {
        isRequesting.value = false;
        Update();
        print(value);
        if (value != null) {
          Submitstatus.value = value['result'];
          Update();
        } else {
          Submitstatus.value = '';
          Update();
        }
      });
    } on Exception catch (e) {
      isRequesting.value = false;
      Submitstatus.value = '';
      Update();
      print(e);
    }
    print("ORDER REQ----->${data}");
  }

  reqRemoveFromCart({required String id}) {
    cartItemDao.deleteCartItemByID(id);
    loadData();
  }

  //Paste  unused codes for location here

  RxBool isRequesting = false.obs;
  RxString Submitstatus = ''.obs;
  requestCheckout() async {
    if (isbeatCustomerEmpty()) {
      Get.snackbar("Notice", "You must select beat and customer to place order",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          animationDuration: Duration(seconds: 0),
          borderRadius: 0,
          duration: Duration(seconds: 1));
    } else {
      Random random = Random();
      int orderId = random.nextInt(99999);
      if (lattitude.value != 0.0 && longitude.value != 0.0) {
        if (await IEchecker.checker()) {
          RxList<dynamic> allItems = <dynamic>[].obs;

          // -----------------Running old code-------//
          cartItems.forEach((element) async {
            allItems.add({
              "name": element.productName,
              "brand": element.brand,
              "productId": element.productId.toString(),
              "quantity": element.quantity,
              "totalPrice": element.price,
              "unitPrice": element.unitPrice,
            });
          });
          //Created a structured list of products
          RxMap<String, dynamic> saleRequisation = <String, dynamic>{}.obs;
          saleRequisation.value = {
            "orderId": "ORD${orderId}", //Order id looks like 'ORD12345'
            "customerId": selectedCustomerId.toString().split(" ~")[0],
            "lattitude": lattitude, //looks like 20.1234
            "longitude": longitude, //looks like 20.1234
            "totalItemCount": cartItems.length, // in number like 3 or 4
            "dateTime": DateTime.now()
                .toString(), // looks like 2023-05-10 09:55:06.602402
            "totalPrice": totalPrice.value, // like 2034.23
            "beatName": dropdownBeatValue.value, //String
            "customerName": dropdownCustomerValue.value,
            "createBy:": Pref.readData(key: Pref.USER_ID), //String
            "items": allItems.length == 0
                ? []
                : allItems, //[ {"brand": 'nior' "productId": 'Sku1234', "quantity": 5,"totalPrice": 3000,"unitPrice": 800, } ]
          };
          await requestOnlineCheckout(data: saleRequisation);
          if (Submitstatus.value != '') {
            print('success');
          } else {
            OfflineOrder item =
                OfflineOrder(orderId: "ORD${orderId}", status: "offline");
            await offlineOrderDao.insertOfflineOrdertItem(
                item); //Saving this info in offline sync list database
            await offlineOrderDao
                .findAllOfflineOrder()
                .then((value) => print(value[0].orderId));

            // OrderItem orderItem = OrderItem(
            //     orderId: "ORD${orderId}",
            //     userId: "${Pref.readData(key: Pref.USER_ID)}",
            //     lattitude: lattitude.value,
            //     longitude: longitude.value,
            //     CustomerId: selectedCustomerId.value.toString().split(" ~")[0],
            //     status: "Pending",
            //     totalItem: cartItems.length,
            //     dateTime: DateTime.now().toString(),
            //     totalPrice: totalPrice.value,
            //     beatName: dropdownBeatValue.value,
            //     CustomerName: dropdownCustomerValue.value);
            // await orderItemDao.insertOrderItem(orderItem);
            // cartItems.forEach((element) async {
            //   SaleRequisition item = SaleRequisition(
            //       userId: "${Pref.readData(key: Pref.USER_ID)}",
            //       orderId: "ORD${orderId}",
            //       productId: element.productId.toString(),
            //       customerName: dropdownCustomerValue.value,
            //       beatName: dropdownBeatValue.value,
            //       productName: element.productName,
            //       catagory: element.catagory,
            //       unit: element.unit,
            //       image: element.image,
            //       price: element.price!,
            //       brand: element.brand,
            //       quantity: element.quantity);
            //   await saleRequisitionDao.insertSaleItem(item);
            // });
            // await cartItemDao
            //     .deleteCartItemByuserID(Pref.readData(key: Pref.USER_ID))
            //     .then((value) {
            //   cartItems.clear();
            //   cartItems.refresh();
            // });

            // Update();
          }

          OrderItem orderItem = OrderItem(
              orderId: "ORD${orderId}",
              userId: "${Pref.readData(key: Pref.USER_ID)}",
              CustomerId: selectedCustomerId.value.toString().split(" ~")[0],
              lattitude: lattitude.value,
              longitude: longitude.value,
              status: Submitstatus.value != '' ? Submitstatus.value : "Pending",
              totalItem: cartItems.length,
              dateTime: DateTime.now().toString(),
              totalPrice: totalPrice.value,
              beatName: dropdownBeatValue.value,
              CustomerName: dropdownCustomerValue.value);
          await orderItemDao.insertOrderItem(
              orderItem); //Saving a single order info where order Id is the primary key
          cartItems.forEach((element) async {
            SaleRequisition item = SaleRequisition(
                userId: "${Pref.readData(key: Pref.USER_ID)}",
                orderId: "ORD${orderId}",
                productId: element.productId.toString(),
                customerName: dropdownCustomerValue.value,
                beatName: dropdownBeatValue.value,
                productName: element.productName,
                catagory: element.catagory,
                unit: element.unit,
                image: element.image,
                price: element.price!,
                brand: element.brand,
                quantity: element.quantity);
            await saleRequisitionDao.insertSaleItem(item);
          });
          //Inserting products agains order id one by one.A single order can have multiple products
          await cartItemDao
              .deleteCartItemByuserID(Pref.readData(key: Pref.USER_ID))
              .then((value) {
            cartItems.clear();
            cartItems.refresh();
            QuickAlert.show(
              confirmBtnColor: AppThemes.modernGreen,
              context: Get.context!,
              type: QuickAlertType.success,
              // autoCloseDuration: Duration(seconds: 2),
            );
          });
          Update();
        } else {
          //If there is no internet, this proceedure will be called
          OfflineOrder item =
              OfflineOrder(orderId: "ORD${orderId}", status: "offline");
          await offlineOrderDao.insertOfflineOrdertItem(
              item); //Saving this info in offline sync list database
          await offlineOrderDao
              .findAllOfflineOrder()
              .then((value) => print(value[0].orderId));

          OrderItem orderItem = OrderItem(
              orderId: "ORD${orderId}",
              userId: "${Pref.readData(key: Pref.USER_ID)}",
              lattitude: lattitude.value,
              longitude: longitude.value,
              CustomerId: selectedCustomerId.value.toString().split(" ~")[0],
              status: "Pending",
              totalItem: cartItems.length,
              dateTime: DateTime.now().toString(),
              totalPrice: totalPrice.value,
              beatName: dropdownBeatValue.value,
              CustomerName: dropdownCustomerValue.value);
          await orderItemDao.insertOrderItem(orderItem);
          cartItems.forEach((element) async {
            SaleRequisition item = SaleRequisition(
                userId: "${Pref.readData(key: Pref.USER_ID)}",
                orderId: "ORD${orderId}",
                productId: element.productId.toString(),
                customerName: dropdownCustomerValue.value,
                beatName: dropdownBeatValue.value,
                productName: element.productName,
                catagory: element.catagory,
                unit: element.unit,
                image: element.image,
                price: element.price!,
                brand: element.brand,
                quantity: element.quantity);
            await saleRequisitionDao.insertSaleItem(item);
          });
          await cartItemDao
              .deleteCartItemByuserID(Pref.readData(key: Pref.USER_ID))
              .then((value) {
            cartItems.clear();
            cartItems.refresh();
            QuickAlert.show(
              confirmBtnColor: AppThemes.modernGreen,
              context: Get.context!,
              type: QuickAlertType.success,
            );
          });

          Update();
        }
      } else {
        Get.snackbar("Warning", "Enable location to order product",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            animationDuration: Duration(seconds: 0),
            borderRadius: 0,
            duration: Duration(seconds: 1));
        await permissionchecker();
      }
    }
  }

  RxBool isSaved = false.obs;
  isSavedUpdater({required bool status}) {
    isSaved.value = status;
    Update();
  }

  saveOrder() async {
    Random random = Random();
    int saveId = random.nextInt(99999);
    SaveItem saveItem = SaveItem(
        saveId: "SAVE${saveId}",
        userId: "${Pref.readData(key: Pref.USER_ID)}",
        lattitude: lattitude.value,
        longitude: longitude.value,
        CustomerId: selectedCustomerId.value.toString().split(" ~")[0],
        status: "SAVED",
        totalItem: cartItems.length,
        dateTime: DateTime.now().toString(),
        totalPrice: totalPrice.value,
        beatName: dropdownBeatValue.value,
        CustomerName: dropdownCustomerValue.value);
    await saveItemDao.insertSaveItem(saveItem);
    cartItems.forEach((element) async {
      SaleRequisition item = SaleRequisition(
          userId: "${Pref.readData(key: Pref.USER_ID)}",
          orderId: "SAVE${saveId}",
          productId: element.productId.toString(),
          customerName: dropdownCustomerValue.value,
          beatName: dropdownBeatValue.value,
          productName: element.productName,
          catagory: element.catagory,
          unit: element.unit,
          image: element.image,
          price: element.price!,
          brand: element.brand,
          quantity: element.quantity);
      await saleRequisitionDao.insertSaleItem(item);
    });
    isSavedUpdater(status: true);
    Update();
    await successAlert();
    Timer(Duration(seconds: 1), () {
      Get.back();
    });
  }
  //sync//

  RxDouble totalPrice = 0.0.obs;
  totalPriceCounter() {
    totalPrice.value = 0.0;
    Update();
    cartItems.forEach((element) {
      totalPrice.value += element.price!;
      Update();
    });
    Update();
  }

  RxDouble lattitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString address = "".obs;
  RxBool isLocationLoading = false.obs;

  getlocation() async {
    isLocationLoading.value = true;
    Update();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return LocationData;
      }
    }
    await location.changeSettings(
      accuracy: LocationAccuracy.high,
    );
    _locationData = await location.getLocation();
    // print(_locationData.latitude);

    LocationData locationData = _locationData;
    lattitude.value = locationData.latitude ?? 0.0;
    longitude.value = locationData.longitude ?? 0.0;
    Update();

    List<gcode.Placemark> placemarks = await gcode.placemarkFromCoordinates(
            double.parse(lattitude.value.toStringAsFixed(4)),
            double.parse(longitude.value.toStringAsFixed(4))) ??
        [];
    address.value = placemarks.isEmpty
        ? "[${lattitude.value},${lattitude.value}]"
        : "${placemarks[0].street}" +
            "," +
            "${placemarks[0].subLocality}" +
            "," +
            "${placemarks[0].locality}" +
            "-" +
            "${placemarks[0].postalCode}";
    isLocationLoading.value = false;
    Map<String, dynamic> tempLocation = {
      "time": DateTime.now().toString().split(" ")[1],
      "lattitude": "${double.parse(lattitude.value.toStringAsFixed(4))}",
      "longitude": "${double.parse(longitude.value.toStringAsFixed(4))}",
      "name": address.value
    };

    Update();
    print("${address.value}");
    return locationData;
  }

  //----------------Weather Code------------//

  RxMap<String, dynamic> weatherData = <String, dynamic>{}.obs;
  RxBool isWeatherLoading = false.obs;

  requestWeather() async {
    isWeatherLoading.value = true;
    Update();
    await getlocation();
    if (lattitude.value != 0.0 && longitude.value != 0.0) {
      await Repository()
          .requestWeather(
              lattitude: lattitude.value, longitude: longitude.value)
          .then((value) {
        if (value != null) {
          print(value);
          weatherData.value = value;
          weatherData.refresh();
        }
        isWeatherLoading.value = false;
        Update();
      });
    }
  }

  //----------------------------------------Beat customer-------------------------------------------//
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
  RxString dropdownCustomerValue = 'Select Customer'.obs;
  RxList<String> customerData = <String>['Select Customer'].obs;

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
      isBeatLoading.value = true;
      Update();
    }
  }

  requestCustomerList() async {
    isCustomerLoading.value = true;
    Update();
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
      offlineDropDowns();
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
      isBeatLoading.value = false;
      Update();
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
      isCustomerLoading.value = false;
      Update();
      customiseCustomerList(beatName: beatData[0]);
      // DropdownCustomerValueUpdater(customerData[0]);
    } else {
      customerData.value = [];
      dropdownCustomerValue.value = '';
      isCustomerLoading.value = false;
      Update();
    }
  }

  int findCartItemIndex(String productId) {
    for (int index = 0; index < cartItems.length; index++) {
      if (cartItems[index].productId == productId) {
        print("The index is : ${index}");
        return index;
      }
    }
    return -1; // If no match is found
  }

  readBeatCustomerStatus() {
    String beatName = Pref.readData(key: Pref.BEAT_NAME) ?? '';
    String CustomerName = Pref.readData(key: Pref.CUSTOMER_NAME) ?? '';
    String customerCode = Pref.readData(key: Pref.CUSTOMER_CODE) ?? '';
    if (beatName != '' && CustomerName != '' && customerCode != '') {
      dropdownBeatValue.value = beatName;
      dropdownCustomerValue.value = CustomerName;
      selectedCustomerId.value = customerCode;

      Update();
    }
  }

  isbeatCustomerEmpty() {
    if (dropdownBeatValue.value == '' ||
        dropdownCustomerValue.value == '' ||
        selectedCustomerId.value == '' ||
        dropdownBeatValue.value == null ||
        dropdownCustomerValue.value == null ||
        selectedCustomerId.value == null) {
      return true;
    } else {
      return false;
    }
  }

  successAlert() async {
    Get.closeAllSnackbars();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
                            "Saved for later!",
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
//--------------Location concent---------------//

  permissionchecker() async {
    Location location = new Location();
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      print("has permission");
      await getlocation();
      await requestWeather();
    } else {
      await userconsent();
    }
  }

  userconsent() {
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
                      Expanded(
                        child: Text(
                          "Prominent Disclosure for Remark Sales",
                          style: TextStyle(),
                        ),
                      ),
                      InkWell(
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
                    height: MediaQuery.of(Get.context!).size.height / 1.5,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Text(
                            "Prominent Disclosure for Remark Sales \n Before you grant location access to Remark Sales, please review the following information: \n This app collects location data to enable the following features: \n Employee attendance tracking: Allows us to record your location when you check-in or check-out of your workplace. \n Geo-fencing: Enables us to create virtual boundaries for designated work areas and provide location-based notifications. \n Route optimization: Helps us suggest the most efficient routes for employees traveling to different work locations."),
                      ),
                    ),
                  ),
                  actionsPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () async {
                                Get.back();
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppThemes.modernSexyRed,
                                    borderRadius: BorderRadius.circular(2)),
                                alignment: Alignment.center,
                                child: Text("Decline",
                                    style: TextStyle(color: Colors.white)),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () async {
                                Get.back();
                                await getlocation();
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppThemes.modernGreen,
                                    borderRadius: BorderRadius.circular(2)),
                                alignment: Alignment.center,
                                child: Text("Allow",
                                    style: TextStyle(color: Colors.white)),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    saleRequisitionDao = database.saleRequisitionDao;
    orderItemDao = database.orderItemDao;
    offlineOrderDao = database.offlineOrderDao;
    saveItemDao = database.saveItemDao;
    readBeatCustomerStatus();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

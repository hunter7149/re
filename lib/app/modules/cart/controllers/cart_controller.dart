import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:sales/app/DAO/offlineOrderDao.dart';
import 'package:sales/app/DAO/orderItemDao.dart';
import 'package:sales/app/DAO/saleRequisitionDao.dart';
import 'package:sales/app/components/connection_checker.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/models/offlineorder.dart';
import 'package:sales/app/models/orderItem.dart';
import 'package:sales/app/models/saleRequisition.dart';
import 'package:geocoding/geocoding.dart' as gcode;
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

  RxList<CartItem> cartItems = <CartItem>[].obs;
  loadData() async {
    initialDropdownValue();
    cartItems.clear();
    cartItems.refresh();
    await cartItemDao.findAllCartItem().then((value) {
      cartItems.value = value;
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
        userId: 1,
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
    cartItems.clear();
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
      });
    } on Exception catch (e) {
      isRequesting.value = false;
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

  requestCheckout() async {
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
          "CustomerName": dropdownCustomerValue.value, //String
          "items": allItems.length == 0
              ? []
              : allItems, //[ {"brand": 'nior' "productId": 'Sku1234', "quantity": 5,"totalPrice": 3000,"unitPrice": 800, } ]
        };
        requestOnlineCheckout(data: saleRequisation);
        OrderItem orderItem = OrderItem(
            orderId: "ORD${orderId}",
            userId: 1,
            CustomerId: selectedCustomerId.value.toString().split(" ~")[0],
            lattitude: lattitude.value,
            longitude: longitude.value,
            status: "Pending",
            totalItem: cartItems.length,
            dateTime: DateTime.now().toString(),
            totalPrice: totalPrice.value,
            beatName: dropdownBeatValue.value,
            CustomerName: dropdownCustomerValue.value);
        await orderItemDao.insertOrderItem(
            orderItem); //Saving a single order info where order Id is the primary key
        cartItems.forEach((element) async {
          SaleRequisition item = SaleRequisition(
              userId: 1,
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
        await cartItemDao.deleteCartItemByuserID(1).then((value) {
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
            userId: 1,
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
              userId: 1,
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
        await cartItemDao.deleteCartItemByuserID(1).then((value) {
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
      await getlocation();
    }
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
    } on Exception catch (e) {
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
    } on Exception catch (e) {
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

  @override
  Future<void> onInit() async {
    super.onInit();
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    saleRequisitionDao = database.saleRequisitionDao;
    orderItemDao = database.orderItemDao;
    offlineOrderDao = database.offlineOrderDao;

    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

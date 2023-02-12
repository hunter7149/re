import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:red_tail/app/DAO/orderItemDao.dart';
import 'package:red_tail/app/DAO/saleRequisitionDao.dart';
import 'package:red_tail/app/components/location_data.dart';
import 'package:red_tail/app/models/orderItem.dart';
import 'package:red_tail/app/models/saleRequisition.dart';

import '../../../DAO/cartitemdao.dart';
import '../../../database/database.dart';
import '../../../models/cartproduct.dart';

class CartController extends GetxController {
  late CartItemDao cartItemDao;
  late OrderItemDao orderItemDao;
  late SaleRequisitionDao saleRequisitionDao;

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
  }

  RxList<CartItem> cartItems = <CartItem>[].obs;
  loadData() async {
    cartItems.clear();
    cartItems.refresh();
    await cartItemDao.findAllCartItem().then((value) {
      cartItems.value = value;
      cartItems.refresh();
      totalPriceCounter();
      print("dta length -> ${cartItems.length}");
    });
  }

  priceQuantiyUpdater(
      {required int index, required String quantity, required String price}) {
    CartItem newItem = CartItem(
        userId: 1,
        productId: cartItems[index].productId,
        beatName: "",
        customerName: "dropdownCustomerValue.value",
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
    totalPriceCounter();
    Update();
  }

  getLocation() async {
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

    _locationData = await location.getLocation();
    // print(_locationData.latitude);
    LocationData locationData = _locationData;
    return locationData;
  }

  requestCheckout() async {
    //--------------------lOCATION ZONE------------------//
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

    _locationData = await location.getLocation();
    // print(_locationData.latitude);
    LocationData locationData = _locationData;
    Random random = Random();
    int orderId = random.nextInt(9999);
    OrderItem orderItem = OrderItem(
        orderId: orderId,
        userId: 1,
        lattitude: locationData.latitude ?? 0.0,
        longitude: locationData.longitude ?? 0.0,
        status: "Pending",
        totalItem: cartItems.length,
        dateTime: DateTime.now().toString(),
        totalPrice: totalPrice.value);
    await orderItemDao.insertOrderItem(orderItem);
    cartItems.forEach((element) async {
      SaleRequisition item = SaleRequisition(
          userId: 1,
          orderId: orderId,
          productId: element.productId,
          customerName: "",
          beatName: "",
          productName: element.productName,
          catagory: element.catagory,
          unit: element.unit,
          image: element.image,
          price: element.price,
          brand: element.brand,
          quantity: element.quantity);
      await saleRequisitionDao.insertSaleItem(item);
    });
    await cartItemDao.deleteUsersByID(1).then((value) {
      cartItems.clear();
      cartItems.refresh();
      CoolAlert.show(
        context: Get.context!,
        type: CoolAlertType.success,
        // text: "Order Successfull!",
      );
    });

    Update();
  }

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
  // RxDouble totalPrice = 0.0.obs;
  // calculation({required double price, required int quantity}) {
  //   totalPrice.value = price * quantity;
  //   update();
  // }

  @override
  Future<void> onInit() async {
    super.onInit();
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    saleRequisitionDao = database.saleRequisitionDao;
    orderItemDao = database.orderItemDao;

    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

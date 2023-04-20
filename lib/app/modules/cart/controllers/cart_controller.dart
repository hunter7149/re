import 'dart:math';
import 'package:get/get.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:red_tail/app/DAO/orderItemDao.dart';
import 'package:red_tail/app/DAO/saleRequisitionDao.dart';
import 'package:red_tail/app/config/app_themes.dart';
import 'package:red_tail/app/models/orderItem.dart';
import 'package:red_tail/app/models/saleRequisition.dart';
import 'package:geocoding/geocoding.dart' as gcode;
import '../../../DAO/cartitemdao.dart';
import '../../../api/repository/repository.dart';
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
    initialDropdownValue();
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
    totalPriceCounter();
    Update();
  }

  screenRefresh() {
    cartItems.refresh();
    Update();
  }

  reqRemoveFromCart({required int index}) {
    cartItemDao.deleteCartItemByID(cartItems[index].id!);
    cartItems.removeAt(index);
    cartItems.refresh();
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
          customerName: dropdownCustomerValue.value,
          beatName: dropdownBeatValue.value,
          productName: element.productName,
          catagory: element.catagory,
          unit: element.unit,
          image: element.image,
          price: element.price,
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
      // CoolAlert.show(
      //     context: Get.context!,
      //     type: CoolAlertType.success,
      //     animType: CoolAlertAnimType.slideInDown
      //     // text: "Order Successfull!",
      //     );
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
        double.parse(longitude.value.toStringAsFixed(4)));
    address.value = "${placemarks[0].street}" +
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
  List<Map<String, dynamic>> beatCustomer = <Map<String, dynamic>>[
    {
      "beatname": "Digpait",
      "customers": [
        'Allahor Dan Store',
        'Aporupa Cos.',
        'Baba mayar Doua store',
        'Babul Store',
        'Bai Bai Store',
        'Bismilla Store',
        'Eti Store',
        'Fohad store',
        'Forid store',
        'Galava Cosmeticse',
        'Harun Cosmeticse',
        'Hassan Ent',
        'Jahangir Store',
        'Jonnony Cosmeticse',
        'Junayet Store',
        'Khan paper House',
        'Lija Store',
        'Ma Cosmeticse',
        'Maruf Cosmeticse',
        'Matara store',
        'Mayer Achol Cos',
        'Meshok cosmetics',
        'Mim Store',
        'Misuk Cos',
        'Modina store',
        'Moinal store',
        'Momin cosmetics',
        'Mondira store',
        'Nimay Store',
        'Nupor Varaitice',
        'Poran store',
        'Protasha Con.',
        'Radoy Cosmeticse',
        'Raja khan Store',
        'Rakib Store',
        'Robiul store',
        'Rofiqul store',
        'Rokon Store',
        'RomaRony store',
        'Roni store',
        'Saiful Cosmeticse',
        'Sakil Store',
        'Santa store',
        'Shimul Cosmeticse',
        'Shohid Store',
        'Shoriny Traders',
        'Sithi Store',
        'Sobus nur store',
        'Sohag store',
        'Sojona Cos',
        'Somun cosmetics',
        'Sulaiman Store',
        'Sumi Cosmeticse',
        'Tanjena store',
        'uzzal Cosmeticse'
      ]
    },
    {
      "beatname": "Gupalpur Bazar",
      "customers": [
        'AF AM store',
        'Afaj Store',
        'Allamin store',
        'Amdadul store',
        'Anowar Store',
        'Bai Bai Store',
        'Bismillah Store',
        'Chomot kar Store',
        'Ebrahim store',
        'Garments cosmetics',
        'Karim Store',
        'Khan cosmetics',
        'Khan Shopping Store',
        'Ladys Corner',
        'Ma Babar Dowa',
        'Malek store',
        'Maruf cosmetics',
        'Mayar Achal store',
        'Melion store',
        'Mohi Uddin',
        'New Bismillah Store',
        'Nirob Varaitice',
        'Ria Moni Varaitice',
        'Rokon Store',
        'Salam Store',
        'Shafin store',
        'Sobuj Cosmetics',
        'Sohel store',
        'Sohel Store',
        'Subhan Store',
        'Tanvir Store',
        'Zyaul store'
      ]
    },
    {
      "beatname": "Kothakoli Market",
      "customers": [
        'Abdus Satter Moslagor',
        'Abu Sama Trades',
        'Afjal Store',
        'Amin Store',
        'Anuwer Rokomary',
        'Chori Ghor Cos',
        'Dav Store',
        'Faria Cosmetics',
        'Fashoin Word',
        'Hoqe Varaitice',
        'Istiak Varaitics',
        'Jonatar Prethibi',
        'Kanu Store',
        'Katbo Cos',
        'Lipu Corner',
        'Luva confectionary',
      ]
    }
  ];

  //-------------------------Beat Dropdown menu--------------------//

  RxString dropdownBeatValue = 'Select Beat '.obs;
  RxList<String> beatList = <String>[
    'Select Beat ',
  ].obs;
  DropdownBeatValueUpdater(String type) {
    dropdownBeatValue.value = type;
    // customersData.clear();
    print("hhhhh -0---------------------> ${beatCustomer}");
    print(
        "Hello position -> ${beatCustomer[beatCustomer.indexWhere((element) => element['beatname'] == type)]["customers"]}");
    customersData.value = beatCustomer[beatCustomer
        .indexWhere((element) => element['beatname'] == type)]["customers"];
    // beatCustomer.refresh();
    // beatCustomer.forEach((element) {
    //   if (element["beatname"] == type) {
    //     customersData.value = (element["customers"]);
    //   }
    // });
    customersData.refresh();

    dropdownCustomerValue.value = customersData[0];

    Update();
  }

  beatCustomerValueSetterTemporary() async {
    beatCustomer.clear();
    beatCustomer = <Map<String, dynamic>>[
      {
        "beatname": "Digpait",
        "customers": [
          'Allahor Dan Store',
          'Aporupa Cos.',
          'Baba mayar Doua store',
          'Babul Store',
          'Bai Bai Store',
          'Bismilla Store',
          'Eti Store',
          'Fohad store',
          'Forid store',
          'Galava Cosmeticse',
          'Harun Cosmeticse',
          'Hassan Ent',
          'Jahangir Store',
          'Jonnony Cosmeticse',
          'Junayet Store',
          'Khan paper House',
          'Lija Store',
          'Ma Cosmeticse',
          'Maruf Cosmeticse',
          'Matara store',
          'Mayer Achol Cos',
          'Meshok cosmetics',
          'Mim Store',
          'Misuk Cos',
          'Modina store',
          'Moinal store',
          'Momin cosmetics',
          'Mondira store',
          'Nimay Store',
          'Nupor Varaitice',
          'Poran store',
          'Protasha Con.',
          'Radoy Cosmeticse',
          'Raja khan Store',
          'Rakib Store',
          'Robiul store',
          'Rofiqul store',
          'Rokon Store',
          'RomaRony store',
          'Roni store',
          'Saiful Cosmeticse',
          'Sakil Store',
          'Santa store',
          'Shimul Cosmeticse',
          'Shohid Store',
          'Shoriny Traders',
          'Sithi Store',
          'Sobus nur store',
          'Sohag store',
          'Sojona Cos',
          'Somun cosmetics',
          'Sulaiman Store',
          'Sumi Cosmeticse',
          'Tanjena store',
          'uzzal Cosmeticse'
        ]
      },
      {
        "beatname": "Gupalpur Bazar",
        "customers": [
          'AF AM store',
          'Afaj Store',
          'Allamin store',
          'Amdadul store',
          'Anowar Store',
          'Bai Bai Store',
          'Bismillah Store',
          'Chomot kar Store',
          'Ebrahim store',
          'Garments cosmetics',
          'Karim Store',
          'Khan cosmetics',
          'Khan Shopping Store',
          'Ladys Corner',
          'Ma Babar Dowa',
          'Malek store',
          'Maruf cosmetics',
          'Mayar Achal store',
          'Melion store',
          'Mohi Uddin',
          'New Bismillah Store',
          'Nirob Varaitice',
          'Ria Moni Varaitice',
          'Rokon Store',
          'Salam Store',
          'Shafin store',
          'Sobuj Cosmetics',
          'Sohel store',
          'Sohel Store',
          'Subhan Store',
          'Tanvir Store',
          'Zyaul store'
        ]
      },
      {
        "beatname": "Kothakoli Market",
        "customers": [
          'Abdus Satter Moslagor',
          'Abu Sama Trades',
          'Afjal Store',
          'Amin Store',
          'Anuwer Rokomary',
          'Chori Ghor Cos',
          'Dav Store',
          'Faria Cosmetics',
          'Fashoin Word',
          'Hoqe Varaitice',
          'Istiak Varaitics',
          'Jonatar Prethibi',
          'Kanu Store',
          'Katbo Cos',
          'Lipu Corner',
          'Luva confectionary',
        ]
      }
    ];
    Update();
  }

  //---------------------------Customer dropdown value--------------------//
  RxString dropdownCustomerValue = 'Select Customer'.obs;
  RxList<String> customersData = <String>[
    'Select Customer',
  ].obs;
  DropdownCustomerValueUpdater(String type) {
    dropdownCustomerValue.value = type;

    Update();
  }

  initialDropdownValue() {
    beatCustomerValueSetterTemporary();
    beatList.clear();
    customersData.clear();
    beatCustomer.forEach((element) {
      beatList.add(element['beatname']);
    });
    beatList.refresh();

    dropdownBeatValue.value = beatCustomer[0]["beatname"];
    // DropdownCustomerValueUpdater(beatCustomer[0]["beatname"]);

    customersData.clear();
    beatCustomer.forEach((element) {
      if (element["beatname"] == beatCustomer[0]["beatname"]) {
        customersData.value = (element["customers"]);
      }
    });
    customersData.refresh();

    dropdownCustomerValue.value = customersData[0];

    Update();
  }

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

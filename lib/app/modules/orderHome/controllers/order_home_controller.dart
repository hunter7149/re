import 'dart:async';

import 'package:get/get.dart';
import 'package:red_tail/app/DAO/cartitemdao.dart';
import 'package:red_tail/app/models/cartproduct.dart';

import '../../../DAO/orderItemDao.dart';
import '../../../DAO/saleRequisitionDao.dart';
import '../../../components/cart_value.dart';
import '../../../database/database.dart';
import '../../../models/orderItem.dart';
import '../../../models/saleRequisition.dart';

class OrderHomeController extends GetxController {
  final count = 0.0.obs;
//-------------------Beat and customer dummy list-------------//
  List<Map<String, dynamic>> beatCustomer = <Map<String, dynamic>>[
    {
      "beatname": "beat-1",
      "customers": ["Customer-1", "Customer-2"]
    },
    {
      "beatname": "beat-2",
      "customers": ["Customer-3", "Customer-4"]
    },
    {
      "beatname": "beat-3",
      "customers": ["Customer-5", "Customer-6"]
    }
  ];

  //-------------------------Beat Dropdown menu--------------------//

  RxString dropdownBeatValue = 'Beat-1'.obs;
  RxList<String> beatList = <String>[
    'Beat-1',
    'Beat-2',
    'Beat-3',
    'Beat-4',
    'Beat-5',
    'Beat-6',
    'Beat-7'
  ].obs;
  DropdownBeatValueUpdater(String type) {
    dropdownBeatValue.value = type;
    // customerList.clear();
    print("hhhhh -0---------------------> ${beatCustomer}");
    print(
        "Hello position -> ${beatCustomer[beatCustomer.indexWhere((element) => element['beatname'] == type)]["customers"]}");
    customerList.value = beatCustomer[beatCustomer
        .indexWhere((element) => element['beatname'] == type)]["customers"];
    // beatCustomer.refresh();
    // beatCustomer.forEach((element) {
    //   if (element["beatname"] == type) {
    //     customerList.value = (element["customers"]);
    //   }
    // });
    customerList.refresh();

    dropdownCustomerValue.value = customerList[0];

    update();
  }

  //---------------------------Customer dropdown value--------------------//
  RxString dropdownCustomerValue = 'Shop-123'.obs;
  RxList<String> customerList = <String>[
    'Shop-123',
    'Shop-452',
    'Shop-875',
    'Shop-356',
    'Shop-485',
    'Shop-149',
    'Shop-258'
  ].obs;
  DropdownCustomerValueUpdater(String type) {
    dropdownCustomerValue.value = type;

    update();
  }

  initialDropdownValue() {
    beatList.clear();
    beatCustomer.forEach((element) {
      beatList.add(element['beatname']);
    });
    beatList.refresh();

    dropdownBeatValue.value = beatCustomer[0]["beatname"];
    // DropdownCustomerValueUpdater(beatCustomer[0]["beatname"]);

    customerList.clear();
    beatCustomer.forEach((element) {
      if (element["beatname"] == beatCustomer[0]["beatname"]) {
        customerList.value = (element["customers"]);
      }
    });
    customerList.refresh();
    dropdownCustomerValue.value = customerList[0];

    update();
  }

//----------------Previous order dummy data------------------//
  RxList<Map<String, dynamic>> previousOrder = <Map<String, dynamic>>[].obs;
  beatCustomerValueSet() {
    previousOrder.value = [
      {
        "customer_name": "customer-1",
        "beat_name": "beat-1",
        "user_id": 1,
        "products": <Map<String, dynamic>>[
          {
            "img":
                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
            "productId": 101,
            "name": "Tylox",
            "catagory": "Toilet Cleaner",
            "unit": "pcs",
            "price": 99.5,
            "brand": "Remark",
            "quantity": 5
          },
          {
            "img":
                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
            "productId": 101,
            "name": "Nior Lipgel",
            "catagory": "Lip care",
            "unit": "pcs",
            "price": 120,
            "brand": "Remark",
            "quantity": 10
          },
          {
            "img":
                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
            "productId": 101,
            "name": "Blazor facepowder",
            "catagory": "Face care",
            "unit": "pcs",
            "price": 599.5,
            "brand": "Remark",
            "quantity": 2
          }
        ]
      },
      {
        "customer_name": "customer-1",
        "beat_name": "beat-1",
        "user_id": 1,
        "products": <Map<String, dynamic>>[
          {
            "img":
                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
            "productId": 101,
            "name": "Tylox",
            "catagory": "Toilet Cleaner",
            "unit": "pcs",
            "price": 99.5,
            "brand": "Remark",
            "quantity": 5
          },
          {
            "img":
                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
            "productId": 101,
            "name": "Nior Lipgel",
            "catagory": "Lip care",
            "unit": "pcs",
            "price": 120,
            "brand": "Remark",
            "quantity": 10
          },
          {
            "img":
                "https://shop.shajgoj.com/wp-content/uploads/2022/08/NIOR-Dreamy-Glow-Brightening-Cleansing-Foam-2.jpg",
            "productId": 101,
            "name": "Blazor cream",
            "catagory": "Face care",
            "unit": "pcs",
            "price": 599.5,
            "brand": "Remark",
            "quantity": 2
          }
        ]
      }
    ];
    previousOrder.refresh();
    // beatCustomer.clear();
    // beatCustomer.value = ;
    // beatCustomer.refresh();
    // update();
  }

  RxBool isReorder = false.obs;
  RxBool isReorderCompleted = false.obs;

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
    update();
    loadData();
    Timer(Duration(seconds: 2), () {
      isReorderCompleted.value = true;
      update();
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

    beatCustomerValueSet();
    initialDropdownValue();
  }

//----------------------------Code for previous order suggestion-------------------///
  late OrderItemDao orderItemDao;
  late SaleRequisitionDao saleRequisitionDao;
  RxList<OrderItem> orderItem = <OrderItem>[].obs;
//-----------------------Get Main Order List----------------------//
  reqOrderList() async {
    await orderItemDao.findAllOrderItemBySaleId(1).then((value) async {
      orderItem.clear();
      orderItem.refresh();

      orderItem.value = value;
      orderItem.refresh();
      update();
      if (orderItem.length != 0) {
        if (orderItem.length == 1) {
          await reqOrderedItemsList(
              orderId: orderItem[orderItem.length - 1].orderId!);
        } else {
          await reqOrderedItemsList(
              orderId: orderItem[orderItem.length].orderId!);
        }
      }
      print(orderItem.length);
      update();
    });
  }

//---------------------Get Detailed Order List------------------------//
  RxList<SaleRequisition> itemList = <SaleRequisition>[].obs;
  reqOrderedItemsList({required int orderId}) async {
    saleRequisitionDao.findAllSaleItemBySaleId(orderId, 1).then((value) {
      itemList.clear();
      itemList.refresh();
      itemList.value = value;
      itemList.refresh();
      update();
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

import 'package:get/get.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/models/orderItem.dart';
import 'package:sales/app/models/saleRequisition.dart';

import '../../../DAO/orderItemDao.dart';
import '../../../DAO/saleRequisitionDao.dart';
import '../../../database/database.dart';

class OrderpageController extends GetxController {
  late OrderItemDao orderItemDao;
  late SaleRequisitionDao saleRequisitionDao;
  RxList<OrderItem> orderItem = <OrderItem>[].obs;
//-----------------------Get Main Order List----------------------//
  reqOrderList() async {
    await orderItemDao.findAllOrderItem().then((value) {
      orderItem.clear();
      orderItem.refresh();
      orderItem.value = value;
      // orderItem.reversed;
      orderItem.refresh();
      print(orderItem.length);
      update();
    });
  }

//---------------------Get Detailed Order List------------------------//
  RxList<SaleRequisition> itemList = <SaleRequisition>[].obs;
  reqOrderedItemsList({required String orderId}) async {
    await saleRequisitionDao
        .findAllSaleItemBySaleId(orderId, Pref.readData(key: Pref.USER_ID))
        .then((value) {
      itemList.clear();
      itemList.refresh();
      itemList.value = value;
      itemList.refresh();
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();

    saleRequisitionDao = database.saleRequisitionDao;
    orderItemDao = database.orderItemDao;
    reqOrderList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

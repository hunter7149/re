import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/api/service/prefrences.dart';

import '../../DAO/offlineOrderDao.dart';
import '../../DAO/orderItemDao.dart';
import '../../DAO/saleRequisitionDao.dart';
import '../../api/repository/repository.dart';
import '../../config/app_themes.dart';
import '../../database/database.dart';
import '../../models/offlineorder.dart';
import '../../models/orderItem.dart';
import '../../models/saleRequisition.dart';

class OFFLINEORDERSYNC {
  onlineSync() async {
    late OrderItemDao orderItemDao;
    late OfflineOrderDao offlineOrderDao;
    late SaleRequisitionDao saleRequisitionDao;
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    offlineOrderDao = database.offlineOrderDao;
    orderItemDao = database.orderItemDao;
    saleRequisitionDao = database.saleRequisitionDao;

    RxList<OfflineOrder> orderList = <OfflineOrder>[].obs;

    await offlineOrderDao.findAllOfflineOrder().then((value) {
      orderList.clear();
      orderList.value = value;
      orderList
          .refresh(); //Assigned a list of offline order [id,orderId,status]
      if (orderList.isNotEmpty) {
        orderList.forEach((element) async {
          RxList<OrderItem> orderItem = <OrderItem>[].obs;
//-----------------------Get Main Order List----------------------//

          await orderItemDao
              .findAllOrderItemByOrderId(element.orderId!)
              .then((value) {
            //Requesting info of a this order from Order table
            orderItem.clear();
            orderItem.refresh();

            orderItem.value = value;
            orderItem.refresh();
            print(orderItem.length);

            Update();
          });

//---------------------Get Detailed Order List------------------------//
          RxList<SaleRequisition> itemList = <SaleRequisition>[].obs;

          await saleRequisitionDao
              .findAllSaleItemBySaleId(element.orderId!,
                  1) //Requesting product list of this specific order from sale requisation table
              .then((value) {
            itemList.clear();
            itemList.refresh();
            itemList.value = value;
            itemList.refresh();
            Update();
          });

          RxList<dynamic> allItems = <dynamic>[].obs;
          itemList.forEach((elmnt) async {
            allItems.add({
              "name": elmnt.productName,
              "brand": elmnt.brand,
              "productId": elmnt.productId.toString(),
              "quantity": elmnt.quantity,
              "totalPrice": elmnt.price,
              "unitPrice": elmnt.unitprice,
            });
            allItems.refresh();
          }); //Generating global structure for order placement
          RxMap<String, dynamic> saleRequisation = <String, dynamic>{}.obs;
          saleRequisation.value = {
            "orderId": orderItem[0].orderId,
            "customerId": orderItem[0].CustomerId,
            "lattitude": orderItem[0].lattitude,
            "longitude": orderItem[0].longitude,
            "totalItemCount": orderItem[0].totalItem,
            "dateTime": orderItem[0].dateTime,
            "totalPrice": orderItem[0].totalPrice,
            "beatName": orderItem[0].beatName,
            "customerName": orderItem[0].CustomerName,
            "createBy": Pref.readData(key: Pref.USER_ID),
            "items": allItems.length == 0 ? [] : allItems,
          }; //Final json for order placement
          print("ORDER REQ----->${saleRequisation}");
          itemList.clear();
          orderItem.clear();
          itemList.refresh();
          orderItem.refresh();

          try {
            await Repository().requestSaleRequistion(
                body: {"data": "${saleRequisation}"}).then((value) async {
              print(value);
              if (value != null) {
                if (value['result'].toString().contains('cess')) {
                  Get.closeAllSnackbars();
                  Get.snackbar("SYNC SUCCESS",
                      "OFFLINE ORDERS HAS BEEN SYNCED WITH THE SERVER",
                      backgroundColor: AppThemes.modernGreen,
                      duration: Duration(seconds: 1),
                      animationDuration: Duration(seconds: 0),
                      borderRadius: 0,
                      colorText: Colors.white);
                  await offlineOrderDao.deleteOrderItemByID(element.orderId!);
                }
              } else {
                // Get.snackbar("ORDER SYNC FAILED", "SERVER UNAVAILABLE",
                //     backgroundColor: AppThemes.modernGreen,
                //     duration: Duration(seconds: 2),
                //     animationDuration: Duration(seconds: 0),
                //     borderRadius: 0,
                //     colorText: Colors.white);
              }
            });
          } on Exception catch (e) {
            Get.snackbar("ORDER SYNC FAILED", "SERVER UNAVAILABLE",
                backgroundColor: AppThemes.modernSexyRed,
                duration: Duration(seconds: 2),
                animationDuration: Duration(seconds: 0),
                borderRadius: 0,
                colorText: Colors.white);
            print(e);
          }
        });
      } else {
        print("No order found to sync");
      }
    });
//lets see
  }

  // requestOnlineCheckout({required dynamic data}) async {
  //   try {
  //     await Repository()
  //         .requestSaleRequistion(body: {"data": "${data.value}"}).then((value) {
  //       print(value);
  //       if (value != null) {
  //         return value;
  //       } else
  //         return {};
  //     });
  //   } on Exception catch (e) {
  //     print(e);
  //     return e;
  //   }
  //   print("ORDER REQ----->${data}");
  // }
}

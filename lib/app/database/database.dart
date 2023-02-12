import 'dart:async';
import 'package:floor/floor.dart';
import 'package:red_tail/app/DAO/orderItemDao.dart';
import 'package:red_tail/app/DAO/saleRequisitionDao.dart';
import 'package:red_tail/app/models/cartproduct.dart';
import 'package:red_tail/app/models/orderItem.dart';
import 'package:red_tail/app/models/saleRequisition.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../DAO/cartitemdao.dart';
part 'database.g.dart';

@Database(version: 1, entities: [CartItem, SaleRequisition, OrderItem])
abstract class AppDatabase extends FloorDatabase {
  CartItemDao get cartItemDao;
  SaleRequisitionDao get saleRequisitionDao;
  OrderItemDao get orderItemDao;
}

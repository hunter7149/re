import 'dart:async';
import 'package:floor/floor.dart';
import 'package:red_tail/app/DAO/cartitemdao.dart';
import 'package:red_tail/app/DAO/cartitemdao.dart';
import 'package:red_tail/app/models/cartproduct.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../DAO/cartitemdao.dart';
part 'database.g.dart';

@Database(version: 1, entities: [cartItem])
abstract class AppDatabase extends FloorDatabase {
  CartItemDao get cartItemDao;
}

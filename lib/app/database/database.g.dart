// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartItemDao? _cartItemDaoInstance;

  SaleRequisitionDao? _saleRequisitionDaoInstance;

  OrderItemDao? _orderItemDaoInstance;

  OfflineOrderDao? _offlineOrderDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CartItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `productId` TEXT, `customerName` TEXT, `beatName` TEXT, `productName` TEXT, `catagory` TEXT, `unit` TEXT, `image` TEXT, `price` REAL, `brand` TEXT, `quantity` INTEGER, `unitPrice` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SaleRequisition` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `orderId` TEXT, `productId` TEXT, `customerName` TEXT, `beatName` TEXT, `productName` TEXT, `catagory` TEXT, `unit` TEXT, `image` TEXT, `price` REAL, `brand` TEXT, `quantity` INTEGER, `unitprice` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `orderId` TEXT, `userId` INTEGER, `status` TEXT, `totalItem` INTEGER, `dateTime` TEXT, `lattitude` REAL, `longitude` REAL, `totalPrice` REAL, `beatName` TEXT, `CustomerName` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OfflineOrder` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `orderId` TEXT, `status` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartItemDao get cartItemDao {
    return _cartItemDaoInstance ??= _$CartItemDao(database, changeListener);
  }

  @override
  SaleRequisitionDao get saleRequisitionDao {
    return _saleRequisitionDaoInstance ??=
        _$SaleRequisitionDao(database, changeListener);
  }

  @override
  OrderItemDao get orderItemDao {
    return _orderItemDaoInstance ??= _$OrderItemDao(database, changeListener);
  }

  @override
  OfflineOrderDao get offlineOrderDao {
    return _offlineOrderDaoInstance ??=
        _$OfflineOrderDao(database, changeListener);
  }
}

class _$CartItemDao extends CartItemDao {
  _$CartItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _cartItemInsertionAdapter = InsertionAdapter(
            database,
            'CartItem',
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'productId': item.productId,
                  'customerName': item.customerName,
                  'beatName': item.beatName,
                  'productName': item.productName,
                  'catagory': item.catagory,
                  'unit': item.unit,
                  'image': item.image,
                  'price': item.price,
                  'brand': item.brand,
                  'quantity': item.quantity,
                  'unitPrice': item.unitPrice
                },
            changeListener),
        _cartItemUpdateAdapter = UpdateAdapter(
            database,
            'CartItem',
            ['id'],
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'productId': item.productId,
                  'customerName': item.customerName,
                  'beatName': item.beatName,
                  'productName': item.productName,
                  'catagory': item.catagory,
                  'unit': item.unit,
                  'image': item.image,
                  'price': item.price,
                  'brand': item.brand,
                  'quantity': item.quantity,
                  'unitPrice': item.unitPrice
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartItem> _cartItemInsertionAdapter;

  final UpdateAdapter<CartItem> _cartItemUpdateAdapter;

  @override
  Future<List<CartItem>> findAllCartItem() async {
    return _queryAdapter.queryList('SELECT * FROM CartItem',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            productId: row['productId'] as String?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?,
            unitPrice: row['unitPrice'] as double?));
  }

  @override
  Stream<CartItem?> findCartItemById(String id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM CartItem WHERE productId = ?1',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            productId: row['productId'] as String?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?,
            unitPrice: row['unitPrice'] as double?),
        arguments: [id],
        queryableName: 'CartItem',
        isView: false);
  }

  @override
  Future<void> deleteCartItemByID(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM CartItem WHERE productId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteCartItemByuserID(int userId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM CartItem WHERE userId = ?1',
        arguments: [userId]);
  }

  @override
  Future<void> insertCartItem(CartItem item) async {
    await _cartItemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCartItem(CartItem item) {
    return _cartItemUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

class _$SaleRequisitionDao extends SaleRequisitionDao {
  _$SaleRequisitionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _saleRequisitionInsertionAdapter = InsertionAdapter(
            database,
            'SaleRequisition',
            (SaleRequisition item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'orderId': item.orderId,
                  'productId': item.productId,
                  'customerName': item.customerName,
                  'beatName': item.beatName,
                  'productName': item.productName,
                  'catagory': item.catagory,
                  'unit': item.unit,
                  'image': item.image,
                  'price': item.price,
                  'brand': item.brand,
                  'quantity': item.quantity,
                  'unitprice': item.unitprice
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SaleRequisition> _saleRequisitionInsertionAdapter;

  @override
  Future<List<SaleRequisition>> findAllSaleItem() async {
    return _queryAdapter.queryList('SELECT * FROM SaleRequisition',
        mapper: (Map<String, Object?> row) => SaleRequisition(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            orderId: row['orderId'] as String?,
            productId: row['productId'] as String?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?,
            unitprice: row['unitprice'] as double?));
  }

  @override
  Future<List<SaleRequisition>> findAllSaleItemBySaleId(
    String orderId,
    int userId,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM SaleRequisition WHERE orderId = ?1 AND userId =?2',
        mapper: (Map<String, Object?> row) => SaleRequisition(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            orderId: row['orderId'] as String?,
            productId: row['productId'] as String?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?,
            unitprice: row['unitprice'] as double?),
        arguments: [orderId, userId]);
  }

  @override
  Stream<SaleRequisition?> findSaleItemById(String id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM SaleRequisition WHERE orderId = ?1',
        mapper: (Map<String, Object?> row) => SaleRequisition(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            orderId: row['orderId'] as String?,
            productId: row['productId'] as String?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?,
            unitprice: row['unitprice'] as double?),
        arguments: [id],
        queryableName: 'SaleRequisition',
        isView: false);
  }

  @override
  Future<void> insertSaleItem(SaleRequisition item) async {
    await _saleRequisitionInsertionAdapter.insert(
        item, OnConflictStrategy.abort);
  }
}

class _$OrderItemDao extends OrderItemDao {
  _$OrderItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _orderItemInsertionAdapter = InsertionAdapter(
            database,
            'OrderItem',
            (OrderItem item) => <String, Object?>{
                  'id': item.id,
                  'orderId': item.orderId,
                  'userId': item.userId,
                  'status': item.status,
                  'totalItem': item.totalItem,
                  'dateTime': item.dateTime,
                  'lattitude': item.lattitude,
                  'longitude': item.longitude,
                  'totalPrice': item.totalPrice,
                  'beatName': item.beatName,
                  'CustomerName': item.CustomerName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderItem> _orderItemInsertionAdapter;

  @override
  Future<List<OrderItem>> findAllOrderItem() async {
    return _queryAdapter.queryList('SELECT * FROM OrderItem',
        mapper: (Map<String, Object?> row) => OrderItem(
            id: row['id'] as int?,
            orderId: row['orderId'] as String?,
            userId: row['userId'] as int?,
            status: row['status'] as String?,
            totalItem: row['totalItem'] as int?,
            totalPrice: row['totalPrice'] as double?,
            dateTime: row['dateTime'] as String?,
            lattitude: row['lattitude'] as double?,
            longitude: row['longitude'] as double?,
            beatName: row['beatName'] as String?,
            CustomerName: row['CustomerName'] as String?));
  }

  @override
  Future<List<OrderItem>> findAllOrderItemByOrderId(String orderid) async {
    return _queryAdapter.queryList('SELECT * FROM OrderItem WHERE orderId=?1',
        mapper: (Map<String, Object?> row) => OrderItem(
            id: row['id'] as int?,
            orderId: row['orderId'] as String?,
            userId: row['userId'] as int?,
            status: row['status'] as String?,
            totalItem: row['totalItem'] as int?,
            totalPrice: row['totalPrice'] as double?,
            dateTime: row['dateTime'] as String?,
            lattitude: row['lattitude'] as double?,
            longitude: row['longitude'] as double?,
            beatName: row['beatName'] as String?,
            CustomerName: row['CustomerName'] as String?),
        arguments: [orderid]);
  }

  @override
  Stream<OrderItem?> findOrderItemById(String id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM OrderItem WHERE orderId = ?1',
        mapper: (Map<String, Object?> row) => OrderItem(
            id: row['id'] as int?,
            orderId: row['orderId'] as String?,
            userId: row['userId'] as int?,
            status: row['status'] as String?,
            totalItem: row['totalItem'] as int?,
            totalPrice: row['totalPrice'] as double?,
            dateTime: row['dateTime'] as String?,
            lattitude: row['lattitude'] as double?,
            longitude: row['longitude'] as double?,
            beatName: row['beatName'] as String?,
            CustomerName: row['CustomerName'] as String?),
        arguments: [id],
        queryableName: 'OrderItem',
        isView: false);
  }

  @override
  Future<void> insertOrderItem(OrderItem item) async {
    await _orderItemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }
}

class _$OfflineOrderDao extends OfflineOrderDao {
  _$OfflineOrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _offlineOrderInsertionAdapter = InsertionAdapter(
            database,
            'OfflineOrder',
            (OfflineOrder item) => <String, Object?>{
                  'id': item.id,
                  'orderId': item.orderId,
                  'status': item.status
                },
            changeListener),
        _offlineOrderUpdateAdapter = UpdateAdapter(
            database,
            'OfflineOrder',
            ['id'],
            (OfflineOrder item) => <String, Object?>{
                  'id': item.id,
                  'orderId': item.orderId,
                  'status': item.status
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OfflineOrder> _offlineOrderInsertionAdapter;

  final UpdateAdapter<OfflineOrder> _offlineOrderUpdateAdapter;

  @override
  Future<List<OfflineOrder>> findAllOfflineOrder() async {
    return _queryAdapter.queryList('SELECT * FROM OfflineOrder',
        mapper: (Map<String, Object?> row) => OfflineOrder(
            id: row['id'] as int?,
            orderId: row['orderId'] as String?,
            status: row['status'] as String?));
  }

  @override
  Stream<OfflineOrder?> findorderItemById(String id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM OfflineOrder WHERE orderId = ?1',
        mapper: (Map<String, Object?> row) => OfflineOrder(
            id: row['id'] as int?,
            orderId: row['orderId'] as String?,
            status: row['status'] as String?),
        arguments: [id],
        queryableName: 'OfflineOrder',
        isView: false);
  }

  @override
  Future<void> deleteAllOfflineOrder() async {
    await _queryAdapter.queryNoReturn('DELETE FROM OfflineOrder');
  }

  @override
  Future<void> deleteOrderItemByID(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM OfflineOrder WHERE orderId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteOrderItemByStatus(String status) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM OfflineOrder WHERE status = ?1',
        arguments: [status]);
  }

  @override
  Future<void> insertOfflineOrdertItem(OfflineOrder item) async {
    await _offlineOrderInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateOrderItem(OfflineOrder item) {
    return _offlineOrderUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

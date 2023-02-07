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
            'CREATE TABLE IF NOT EXISTS `cartItem` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `productId` INTEGER, `customerName` TEXT, `beatName` TEXT, `productName` TEXT, `catagory` TEXT, `unit` TEXT, `image` TEXT, `price` REAL, `brand` TEXT, `quantity` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartItemDao get cartItemDao {
    return _cartItemDaoInstance ??= _$CartItemDao(database, changeListener);
  }
}

class _$CartItemDao extends CartItemDao {
  _$CartItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _cartItemInsertionAdapter = InsertionAdapter(
            database,
            'cartItem',
            (cartItem item) => <String, Object?>{
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
                  'quantity': item.quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<cartItem> _cartItemInsertionAdapter;

  @override
  Future<List<cartItem>> findAllCartItem() async {
    return _queryAdapter.queryList('SELECT * FROM cartItem',
        mapper: (Map<String, Object?> row) => cartItem(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            productId: row['productId'] as int?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?));
  }

  @override
  Stream<cartItem?> findCartItemById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM cartItem WHERE userid = ?1',
        mapper: (Map<String, Object?> row) => cartItem(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            productId: row['productId'] as int?,
            customerName: row['customerName'] as String?,
            beatName: row['beatName'] as String?,
            productName: row['productName'] as String?,
            catagory: row['catagory'] as String?,
            unit: row['unit'] as String?,
            image: row['image'] as String?,
            price: row['price'] as double?,
            brand: row['brand'] as String?,
            quantity: row['quantity'] as int?),
        arguments: [id],
        queryableName: 'cartItem',
        isView: false);
  }

  @override
  Future<void> insertCartItem(cartItem item) async {
    await _cartItemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }
}

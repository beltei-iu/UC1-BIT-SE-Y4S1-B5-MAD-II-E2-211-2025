
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbManager {

  String dbName = "ecommerce.db";

  // TABLE
  static const String PRODUCT_TABLE_NAME = "tbl_product";
  static const String CATEGORY_TABLE_NAME = "tbl_category";
  static const String ORDER_TABLE_NAME = "tbl_order";

  // COLUMN
  static const String PRODUCT_ID = "id";
  static const String PRODUCT_NAME = "name";
  static const String PRODUCT_PRICE = "price";
  static const String PRODUCT_DESCRIPTION = "description";
  static const String PRODUCT_IMAGE = "image";

  static const String CATEGORY_ID = "id";
  static const String CATEGORY_NAME = "name";

  static const String ORDER_ID = "id";
  static const String ORDER_PRODUCT_ID = "product_id";
  static const String ORDER_QUANTITY = "quantity";
  static const String ORDER_PRICE = "price";

  // Create Singlon Pattern
  static DbManager? instance = DbManager._init();
  DbManager._init();

  Future<Database> get database async {
      // Create Path
      final dbPath = await getDatabasesPath();
      // Get Path
      // final path = '$dbPath/$dbName';
      final path = join(dbPath, dbName);
      if(kIsWeb){
        var databaseFactory = databaseFactoryFfi;
        final appDocumentsDir = await getApplicationDocumentsDirectory();
        //String dbPath = join(appDocumentsDir.path, "databases", "myDb.db");
        return await databaseFactory.openDatabase(dbPath,);
      }else{
        return await openDatabase(path, version: 1, onCreate: initTable);
      }
  }

  Future initTable(Database db, int version) async{
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';

    String productSql = ''' 
      CREATE TABLE IF NOT EXISTS $PRODUCT_TABLE_NAME (
      id $idType,
      name $textType,
      price $doubleType,
      discount $textType,
      rate $integerType,
      categoryId $integerType
      )
    ''';
    await db.execute(productSql);

    String categorySql = ''' 
      CREATE TABLE $CATEGORY_TABLE_NAME (
      id $idType,
      name $textType,
      nameKm $textType
      )
    ''';
    await db.execute(categorySql);

    String orderSql = ''' 
      CREATE TABLE IF NOT EXISTS $ORDER_TABLE_NAME (
      id $idType,
      productId $integerType,
      quantity $integerType,
      price $doubleType
      )
    ''';
    await db.execute(orderSql);
  }
}
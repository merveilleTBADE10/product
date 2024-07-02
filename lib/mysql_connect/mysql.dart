// import 'package:flutterpanier/product_page/product.dart';
// import 'package:mysql1/mysql1.dart';

// class DatabaseService {
//   static final DatabaseService _instance = DatabaseService._internal();
//   late MySqlConnection _connection;

//   factory DatabaseService() => _instance;

//   DatabaseService._internal();

//   Future<void> openConnection() async {
//     final settings = ConnectionSettings(
//       host: 'localhost',
//       port: 3306,
//       user: 'root',
//       password: 'root',
//       db: 'panier',
//     );

//     _connection = await MySqlConnection.connect(settings);
//   }

//   Future<void> closeConnection() async {
//     await _connection.close();
//   }

//   Future<void> saveProduct(Product product) async {
//     try {
//       await _connection.query(
//         'INSERT INTO products (name, unit_price, wholesale_price, wholesale_quantity, available_quantity) '
//         'VALUES (?, ?, ?, ?, ?)',
//         [product.name, product.unitPrice, product.wholesalePrice, product.wholesaleQuantity, product.availableQuantity],
//       );
//     } catch (e) {
//       print('Error saving product: $e');
//       rethrow; // Propagate the exception
//     }
//   }
// }
import 'package:sqflite/sqflite.dart';

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      unitPrice INTEGER,
      wholesalePrice INTEGER,
      wholesaleQuantity INTEGER,
      availableQuantity INTEGER,
      createdAt TEXT
    )""");
  }

  static Future<Database> dv() async {
    // Initialisez databaseFactoryFfi si vous utilisez sqflite_common_ffi
    sqfliteFfiInit(); 

    return openDatabase(
      'panier.db',
      version: 1,
      onCreate: (Database database, int version) async {
        print("...creating a table...");
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String name, int unitPrice, int wholesalePrice,
      int wholesaleQuantity, int availableQuantity) async {
    final db = await dv();
    final data = {
      'name': name,
      'unitPrice': unitPrice,
      'wholesalePrice': wholesalePrice,
      'wholesaleQuantity': wholesaleQuantity,
      'availableQuantity': availableQuantity,
      'createdAt': DateTime.now().toString()
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await dv();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await dv();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update
  static Future<int> updateItem(int id, String name, int unitPrice,
      int wholesalePrice, int wholesaleQuantity, int availableQuantity) async {
    final db = await dv();
    final data = {
      'name': name,
      'unitPrice': unitPrice,
      'wholesalePrice': wholesalePrice,
      'wholesaleQuantity': wholesaleQuantity,
      'availableQuantity': availableQuantity,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await dv();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

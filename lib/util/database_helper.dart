import 'package:enforcea/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../cart.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
    return _databaseHelper;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'cards.db');

    // var pathDB = await getDatabasesPath();
    // String path = pathDB + 'cart.db';

    await deleteDatabase(path);

    var todoDatabase =
        openDatabase(path, version: 1, onCreate: _createDatabase);

    return todoDatabase;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        count INTEGER,
        name TEXT,
        price INTEGER,
        image_url TEXT,
        date Text,
        isRenewal BOOLEAN
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('cart', orderBy: 'id');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectById(int id) async {
    Database db = await this.database;
    var mapList = await db.query('cart', where: 'id = $id');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectExcludeById(int id) async {
    Database db = await this.database;
    var mapList = await db.query('cart', where: 'id != $id');
    return mapList;
  }

  Future<int> insert(CartModel object) async {
    Database db = await this.database;
    int count = await db.insert('cart', object.toJson());
    return count;
  }

  Future<int> update(CartModel object) async {
    Database db = await this.database;
    int count = await db.update('cart', object.toJson(),
        where: 'id = ?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('cart', where: 'id=?', whereArgs: [id]);

    return count;
  }

  Future<List<CartModel>> getCartList() async {
    var cartMapList = await select();
    int count = cartMapList.length;
    List<CartModel> cartList = List<CartModel>();
    for (int i = 0; i < count; i++) {
      cartList.add(CartModel.fromJson(cartMapList[i]));
    }
    print(cartMapList.toString());
    return cartList;
  }

  Future<List<CartModel>> getCartListById(int id) async {
    var cartMapList = await selectById(id);
    int count = cartMapList.length;
    List<CartModel> cartList = List<CartModel>();
    for (int i = 0; i < count; i++) {
      var cartModel = CartModel.fromJson(cartMapList[i]);
      cartList.add(cartModel);
    }
    return cartList;
  }

  Future<List<CartModel>> getCartListExcludeById(int id) async {
    var cartMapList = await selectExcludeById(id);
    int count = cartMapList.length;
    List<CartModel> cartList = List<CartModel>();
    for (int i = 0; i < count; i++) {
      var cartModel = CartModel.fromJson(cartMapList[i]);
      cartList.add(cartModel);
    }
    return cartList;
  }

  Future<int> clearCart() async {
    Database db = await this.database;
    int count = await db.delete('cart');

    return count;
  }
}

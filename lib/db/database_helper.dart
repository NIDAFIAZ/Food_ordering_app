// lib/db/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_ordering_app/models/food_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_ordering.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE food_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imageUrl TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertFoodItem(FoodItem foodItem) async {
    Database db = await database;
    return await db.insert('food_items', foodItem.toMap());
  }

  Future<List<FoodItem>> getFoodItems() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('food_items');
    return List.generate(maps.length, (i) {
      return FoodItem.fromMap(maps[i]);
    });
  }

  Future<int> deleteFoodItem(int id) async {
    Database db = await database;
    return await db.delete('food_items', where: 'id = ?', whereArgs: [id]);
  }
}

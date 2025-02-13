import 'dart:convert';

import 'package:resto_spot/data/model/customer_review.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = 'resto.db';
  static const String _tableName = 'favourite_resto';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute('''
        CREATE TABLE $_tableName (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          city TEXT,
          address TEXT,
          pictureId TEXT,
          categories TEXT,
          menus TEXT,
          rating REAL,
          customerReviews TEXT
        )
      ''');
  }

  Future<Database> _initializeDb() async {
    return openDatabase(_databaseName, version: _version,
        onCreate: (database, version) async {
      await createTables(database);
    });
  }

  Future<int> insertItem(RestaurantDetail restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    return await db.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<RestaurantDetail>> getAllRestaurants() async {
    final db = await _initializeDb();

    final results = await db.query(_tableName, orderBy: 'name');
    return results.map(_mapToRestaurantDetail).toList();
  }

  Future<RestaurantDetail> getRestaurantById(String id) async {
    final db = await _initializeDb();

    final result =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
    return result.map(_mapToRestaurantDetail).first;
  }

  Future<int> deleteItem(String id) async {
    final db = await _initializeDb();

    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  RestaurantDetail _mapToRestaurantDetail(Map<String, dynamic> result) {
    return RestaurantDetail(
      id: result['id'] as String,
      name: result['name'] as String,
      description: result['description'] as String,
      city: result['city'] as String,
      address: result['address'] as String,
      pictureId: result['pictureId'] as String,
      categories: (jsonDecode(result['categories'] as String) as List)
          .map((x) => Category.fromJson(x))
          .toList(),
      menus: Menus.fromJson(jsonDecode(result['menus'] as String)),
      rating: result['rating'] as double,
      customerReviews: (jsonDecode(result['customerReviews'] as String) as List)
          .map((x) => CustomerReview.fromJson(x))
          .toList(),
    );
  }
}

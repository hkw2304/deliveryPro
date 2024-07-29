import 'package:deliveryproject/domain/store_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'stores';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final database = openDatabase(join(await getDatabasesPath(), 'stores.db'),
        onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE $tableName(BPLCNM TEXT PRIMARY KEY, UPTAENM TEXT, X TEXT, Y TEXT)",
      );
    }, version: 1);
    return database;
  }

  Future<void> insertStore(StoreApi storeApi) async {
    final db = await database;

    await db.insert(tableName, storeApi.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<StoreApi> getStore(String BPLCNM) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      columns: ['BPLCNM', 'UPTAENM', 'X', 'Y'],
      where: 'BPLCNM = ?',
      whereArgs: [BPLCNM],
    );
    return StoreApi.fromJson(maps.first);
  }

  Future<List<StoreApi>> stores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('stores');
    return List.generate(maps.length, (index) {
      return StoreApi(
        BPLCNM: maps[index]['BPLCNM'],
        UPTAENM: maps[index]['UPTAENM'],
        X: maps[index]['X'],
        Y: maps[index]['Y'],
      );
    });
  }

  Future<void> updateStore(StoreApi storeApi) async {
    final db = await database;

    await db.update(
        tableName,
        storeApi.toJson(),
      where: 'BPLCNM = ?',
      whereArgs: [storeApi.BPLCNM],
    );
  }

  Future<void> deleteStore(String BPLCNM) async{
    final db = await database;

    await db.delete(
      tableName,
      where: 'BPLCNM = ?',
      whereArgs: [BPLCNM],
    );
  }

  Future<void> truncateStores() async {
    final db = await database;
    await db.rawDelete('DELETE FROM $tableName');
  }
}

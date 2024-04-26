import '../provider/listprovider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static const DBNAME = "taskDB.db";
  static const DATABASEVERSION = 1;

  static final DBHelper _databaseService = DBHelper._internal();
  factory DBHelper() => _databaseService;

  DBHelper._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = getDirectory.path + '/$DBNAME';
    print(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(TaskProvider.CREATETABLESQL);
    print('TABLE CREATED');
  }

  Future<List<Map<String, Object?>>> getAllRecords(String table) async {
    final db = await _databaseService.database;
    var data = await db.query(table);
    return data;
  }

  Future<List<Map<String, Object?>>> getAllRecordsRawQuery(String sql) async {
    final db = await _databaseService.database;
    var data = await db.rawQuery(sql);
    return data;
  }

  Future<List<Map<String, Object?>>> searchRecordsRawQuery(
      String sql, List<dynamic> args) async {
    final db = await _databaseService.database;
    var data = await db.rawQuery(sql, args);
    return data;
  }

  Future<List<Map<String, Object?>>> searchRecords(
      String table, String where, List<dynamic> args) async {
    final db = await _databaseService.database;
    var data = await db.query(table, where: where, whereArgs: args);
    return data;
  }

  Future<bool> insertRecord(
      String table, Map<String, dynamic> recordTobeInserted) async {
    final db = await _databaseService.database;
    var result = await db.insert(table, recordTobeInserted);
    print('inserted #of Record: $result');
    return result > 0;
  }

  Future<bool> insertRecordRawQuery(String rawQuery, List<dynamic> args) async {
    final db = await _databaseService.database;
    var result = await db.rawInsert(rawQuery, args);
    print('inserted #of RecordRawQuery: $result');
    return result > 0;
  }

  Future<bool> updateRecord(String table, Map<String, dynamic> record,
      String where, List<dynamic> args) async {
    final db = await _databaseService.database;
    var result = await db.update(table, record, where: where, whereArgs: args);
    print('updated# of records: $result with rawquery');
    return result > 0;
  }

  Future<bool> updateRecordRawQuery(String sql, List<dynamic> args) async {
    final db = await _databaseService.database;
    var result = await db.rawUpdate(sql, args);
    print('updated #of RecordRawQuery $result');
    return result > 0;
  }

  Future<bool> deleteRecord(
      String table, String where, List<dynamic> args) async {
    final db = await _databaseService.database;
    var result = await db.delete(table, where: where, whereArgs: args);
    print('deleted #of Records: $result');
    return result > 0;
  }

  Future<bool> deleteRecordRawQuery(String sql, List<dynamic> args) async {
    final db = await _databaseService.database;
    var result = await db.rawDelete(sql, args);
    print('deleted #of RecordRawQuery $result');
    return result > 0;
  }
}

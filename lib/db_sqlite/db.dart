import 'dart:io';
import 'package:delivery_food/models/image_sqlite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/image_sqlite.dart';

class DBSqlite {
  static Database _db;
  static const String ID = "id";
  static const String ImageName = "imageName";
  static const String Table = "photosTablesss";
  static const String DBName = "photossss.db";
  ImagaSqlite imageSql = ImagaSqlite();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DBName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $Table($ID TEXT,$ImageName TEXT)');
  }
  Future<String> change(database,image)async{
    await database.insert(Table, image.toMap()).toString();
  }

   savePhoto(ImagaSqlite image) async {
    var database = await db;
    var row= await change(database, image);
    return row;
  }

  Future<ImagaSqlite> getPhoto(String id) async {
    var database = await db;
    var response = await database.query(Table, where: "id= ?", whereArgs: [id]);
    return response.isNotEmpty ? ImagaSqlite.fromMap(response.first) : null;
  }
}

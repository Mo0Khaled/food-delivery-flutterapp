import 'dart:io';
import 'package:delivery_food/models/image_sqlite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/image_sqlite.dart';

class DBSqlite {
  static Database _dataB;
  static const String Id = "idd";
  static const String ImageNamee = "imageNamee";
  static const String Table = "photosTablessss";
  static const String DBName = "photosssss.db";
  ImageSqlite imageSql = ImageSqlite();

  Future<Database> get db async {
    if (_dataB != null) {
      return _dataB;
    }
    _dataB = await initDB();
    return _dataB;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DBName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $Table($Id TEXT,$ImageNamee TEXT)');
  }

  savePhoto(ImageSqlite image) async {
    var database = await db;
    var row = await database.insert(Table, image.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    var stringRow = row.toString();
    return stringRow;
  }

  Future<ImageSqlite> getPhoto(String id) async {
    var database = await db;
    var response = await database.query(Table, where:"idd= ?", whereArgs: [id]);
    return response.isNotEmpty ? ImageSqlite.fromMap(response.first) : null;
  }
   updateImage(ImageSqlite image)async{
    var database=await db;
    var row=await database.update(Table, image.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    var stringRow = row.toString();
    return stringRow;
  }



}

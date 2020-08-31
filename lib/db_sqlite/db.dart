import 'dart:io';

import 'package:delivery_food/models/image_sqlite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBSqlite {

  static Database db;
  static const String ID="id";
  static const String ImageName="imageName";
  static const String Table="photosTable";
  static const String TableFileName="photos.db";

  createDB()async {
    Directory directory=await getApplicationDocumentsDirectory();
    String path =join(directory.path,TableFileName);
  }

  makeDB(String path) async {
    openDatabase(path,version: 1,onCreate: (Database db,int version){
      db.execute("CREATE TABLE $Table("
          "$ID integer primary-key"
          "$ImageName TEXT"
          ")");
    });
  }
  addPhoto(ImagaSqlite image) async {
  var database=await db;
  var raw=await db.insert(Table,image.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  return raw;
  }
//  fetchPhoto(id)async{
//    final database=await db;
//    var
//  }




}
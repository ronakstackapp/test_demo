import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:test_demo/model/usermodel.dart';



class DataBaseManager {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'my_table';

  static const columnId = 'Id';
  static const columnYourName = 'UserName';
  static const columnEmail = 'Email';
  static const columnBirth = 'BirthDate';
  static const columnPassword = 'Password';
  // static const columnConfirmPassword = 'ConfirmPassword';


  // make this a singleton class
  DataBaseManager._privateConstructor();

  static final DataBaseManager instance = DataBaseManager._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnYourName TEXT NOT NULL,$columnEmail TEXT NOT NULL,'
            '$columnBirth DATETIME NOT NULL,$columnPassword TEXT NOT NULL)');
  }

  Future<int> insert(UserModel data) async {
    // ignore: avoid_print
    print("insert -->>${data.dob}");
    Database? db = await instance.database;
    Map<String, Object> dataMap = {
      columnYourName: data.name!,
      columnEmail: data.email!,
      columnBirth: DateFormat('dd/MM/yyyy').format(data.dob!),
      columnPassword: data.password!,
    };

    return await db!.insert(table, dataMap);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  ///show_all_data
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // Future<List<Map<String, dynamic>>> selectName() async {
  //   Database? db = await instance.database;
  //   return await db!.rawQuery('SELECT * FROM $table WHERE $columnYourName=?', );
  // }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int?> queryRowCount() async {
  //   Database? db = await instance.database;
  //   return Sqflite.firstIntValue(
  //       await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  // }


  ///test
  Future<int?> matchEmailAndPassword(String? email) async {
    print("matchEmailAndPassword DataBAse -->>$email");
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT * FROM $table WHERE $columnEmail=$email'));
  }





  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row,int id) async {
    Database? db = await instance.database;
   // int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }



  Future<int> deleteAllData() async {
    Database? db = await instance.database;
    return await db!.delete(table);
  }


//yards table select
// Future<List<Yards>> getYards() async {
//   Database db = await instance.database;
//   final maps = await db.query(table_yards);
//   debugPrint('Inside the Yards into Local Database ${maps}');
//   return List.generate(maps.length, (index) {
//     return Yards(
//       id: maps[index]['id'].toString(),
//       configSuppliersId:
//       maps[index]['config_suppliers_id'].toString() ?? 'No Config Yard',
//       yardName: maps[index]['yard_name'].toString() ?? 'No Yard name',
//       yardAddress:
//       maps[index]['yard_address'].toString() ?? 'No Yard address',
//       yardLocation:
//       maps[index]['yard_location'].toString() ?? 'No yard location',
//     );
//   });
// }

}

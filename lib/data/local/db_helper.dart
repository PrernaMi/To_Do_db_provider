import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_db_provider/user_model.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstances = DbHelper._();
  static final String tableToDo = "todoTable";
  static final String tableColTitle = "title";
  static final String tableColSno = "s_no";
  static final String tableColDesc = "desc";
  static final String tableColIsCompleted = "isCompleted";

  Database? myDb;

  Future<Database> getDb() async {
    myDb ??= await openDb();
    return myDb!;
  }

  Future<Database> openDb() async {
    Directory myDirectory = await getApplicationDocumentsDirectory();
    String rootPath = myDirectory.path;
    String dbPath = join(rootPath, "todo.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''create table $tableToDo ( 
      $tableColSno Integer primary key autoincrement,
      $tableColTitle text,
      $tableColDesc text,
      $tableColIsCompleted Integer
      )''');
    });
  }

  //add data in db
  Future<bool> addInDb({required String mTitle,
    required String mDesc,}) async {
    var db = await getDb();
    int count = await db.insert(tableToDo,
        UserModel(title: mTitle, desc: mDesc,).toMap());
    return count > 0;
  }

  //get all data
  Future<List<UserModel>> getFromDb() async {
    var db = await getDb();
    List<UserModel> allNotes = [];
    var data = await db.query(tableToDo);
    for (Map<String, dynamic> eachMap in data) {
      allNotes.add(UserModel.fromMap(eachMap));
    }
    return allNotes;
  }

  //update in db
  Future<bool> updateInDb(
      {required String title, required String desc, required int s_no}) async {
    var db = await getDb();
    int count = await db.update(tableToDo,
        UserModel(title: title, desc: desc, s_no: s_no, isCompleted: 0).toMap(),
        where: '$tableColSno = ?', whereArgs: [s_no]);
    return count > 0;
  }

  //delete from db
  Future<bool> deleteFromDb({required int s_no}) async {
    var db = await getDb();
    int count = await db.delete(
        tableToDo, where: '$tableColSno = ?', whereArgs: [s_no]);
    return count > 0;
  }

}

import 'package:sqflite/sqflite.dart';
class Sqlite {
  
  static String path = '/data/user/0/com.lypanharath.kbook/files/kbook.db';
  static int version = 1;

  final database = openDatabase(path, version: version, onCreate: (db, int version) {
    String sql =  "CREATE TABLE tblbook (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,description TEXT NOT NULL,path TEXT NOT NULL);";    
    return db.execute(sql);  
    },
    singleInstance: false);
  

  createBook(String name,String description,String path) async {  
    final Database db = await database;
    String sql = "INSERT INTO tblbook (name,description,path) VALUES ('"+ name + "','" + description + "','" + path + "')";
    var value = await db.rawInsert(sql);
    return value;
  }

  updateBook(String name,String description,String path,String id) async {
    final Database db = await database;
    String sql = "UPDATE tblbook SET name='"+ name + "',description='" + description +"',path='" + path + "' WHERE id='" +id + "'";
    var value = await db.rawUpdate(sql);
    return value;
  }

  deteteBook(String id) async {
    final Database db = await database;
    String sql = "DELETE FROM tblbook WHERE id='" + id + "'";
    var value = await db.delete(sql);
    return value;
  }

  readBook() async {
    final Database db = await database;
    String sql = "SELECT * FROM tblbook";
    var value = await db.rawQuery(sql);
    return value;
  }
}

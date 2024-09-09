import 'package:sqflite/sqflite.dart';

class AppDB {
  static Database? database;
  static Future createDatabase() async {
    await openDatabase(
      'notes.db',
      version: 1,
      onCreate: (database, version) async {
        await database
            .execute(
                'CREATE TABLE notes(note_id INTEGER PRIMARY KEY AUTOINCREMENT, note_title TEXT, note_body TEXT, note_status TEXT, note_fontSize INTEGER, note_dateCreated TEXT, note_dateModified TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
      },
      onOpen: (database) async {
        // var analyticsChecker = (await database
        //         .rawQuery('SELECT * FROM analytics ORDER BY id DESC '))
        //     .toList() as List<Map<String, dynamic>>;
        // if (analyticsChecker.isEmpty) {
        //   database.execute(
        //       'INSERT INTO analytics(date,profit,new_clients) VALUES (?,?,?)',
        //       [DateTime.now().toString().split(' ').first, 0, 0]).then((value) {
        //     print('analytics added');
        //   }).catchError((error) {
        //     if (!error.toString().contains('duplicate column name')) {
        //       print('Error Adding Column ${error.toString()}');
        //     }
        //   });
        // }
      },
    ).then((value) {
      database = value;
    });
  }

  // Future insertDatabase({
  //   required String name,
  //   required amount,
  //   required String code,
  //   required String price,
  //   required String discount,
  // }) async {
  //   return await database?.transaction((txn) async {
  //     txn.rawInsert(
  //         'INSERT INTO data(name, amount, code, price, discount) VALUES(?, ?, ?, ?, ?)',
  //         [name, amount, code, price, discount]).then((value) {
  //       print("$value inserted into database");

  //       // getDatabase(database);
  //     }).catchError((error) {
  //       print('Error Inserting $error');
  //     });
  //   });
  // }

  // void getDatabase(database) {
  //   database.rawQuery('SELECT * FROM data').then((value) {
  //     data = value;
  //     print(data);
  //     emit(AppGetDatabaseState());
  //   });
  // }

  // void updateDatabase(
  //     {required String name,
  //     required amount,
  //     required String code,
  //     required String price,
  //     required int id}) {
  //   database?.rawUpdate(
  //       'UPDATE data SET name = ?, amount = ?, code = ?, price = ? WHERE id = ?',
  //       [name, amount, code, price, id]).then((value) {
  //     getDatabase(database);
  //     emit(AppUpdateDatabase());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  // void deleteDatabase({required int id}) async {
  //   database?.rawDelete('DELETE FROM data WHERE id = ?', [id]).then((value) {
  //     getDatabase(database);
  //     emit(AppDeleteDatabase());
  //   });
  // }

  // Future<Map?> getItemByCode(String code) async {
  //   List<Map> result =
  //       await database?.rawQuery('SELECT * FROM data WHERE code = ?', [code]) ??
  //           [];
  //   if (result.isNotEmpty) {
  //     return result.first;
  //   }
  //   return null;
  // }

  // void updateQuantity(String code, int amount, String discount) {
  //   var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   database?.rawUpdate(
  //     'UPDATE data SET amount = amount - ?, date = ?, discount = ? WHERE code = ?',
  //     [amount, date, discount, code],
  //   ).then((value) {
  //     getDatabase(database);
  //     emit(AppUpdateDatabase());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  // Future<List<Map>> getSalesByDate(String date) async {
  //   return await database
  //           ?.rawQuery('SELECT * FROM data WHERE date = ?', [date]) ??
  //       [];
  // }
}

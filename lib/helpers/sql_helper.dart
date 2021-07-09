import '../providers/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SqlHelper {
  //bills
  static final String colId = 'id';
  static final String colTitle = 'title';
  static final String colTotal = 'total';
  static final String colSubtotal = 'subtotal';
  static final String colVat = 'vat';
  static final String colService = 'service';
  static final String colPno = 'pno';
  static final String tableBills = 'bills';

  //participants
  static final String colPId = 'pid';
  static final String colPname = 'pname';
  static final String colPbill = 'pbill';
  static final String colPbillId = 'pbillId';
  static final String tableParticipants = 'participants';

  static Database _db;
  static final int _version = 1;

  SqlHelper._privateConstructor();
  static final SqlHelper instance = SqlHelper._privateConstructor();

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await init();

    return _db;
  }

  Future init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'bills.db');
    try {
      // var open =
      return await openDatabase(
        dbPath,
        version: _version,
        onCreate: (db, version) {
          return db
              .execute('''CREATE TABLE $tableBills($colId TEXT PRIMARY KEY , 
            $colTitle TEXT, 
            $colTotal REAL,
            $colSubtotal REAL, 
            $colVat REAL, 
            $colService REAL,
            $colPno INTEGER
            )''');
        },
      );
    } catch (error) {
      throw (error);
    }
  }

  Future<void> dropTableIfExists() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'bills.db');
    //here we get the Database object by calling the openDatabase method
    //which receives the path and onCreate function and all the good stuff
    Database db = await openDatabase(dbPath);

    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS tableName");

    //and finally here we recreate our beloved "tableName" again which needs
    //some columns initialization
    // await db.execute("CREATE TABLE tableName (id INTEGER, name TEXT)");
  }

  Future<int> insertBill(
    Bill bill,
  ) async {
    Database _db = await instance.database;

    await _db.execute(
        '''CREATE TABLE IF NOT EXISTS $tableBills($colId TEXT PRIMARY KEY,
            $colTitle TEXT,
            $colTotal TEXT,
            $colSubtotal real ,
            $colVat real,
            $colService real
            $colPno INTEGER

            )''');
    return await _db.insert(tableBills, bill.toMap());
  }

  Future<int> insertParticipants(Participant participant) async {
    await _db.execute('''CREATE TABLE IF NOT EXISTS $tableParticipants(
          $colPId INTEGER PRIMARY KEY,
          $colPname TEXT ,
          $colPbill REAL,
          $colPbillId TEXT,
          FOREIGN KEY($colPbillId) REFERENCES $tableBills($colId) ON DELETE CASCADE
          )''');

    return await _db.insert(tableParticipants, participant.toMap());
  }

  Future<void> deleteTable(Bill bill) async {
    Database _db = await instance.database;
    return await _db.execute('DROP TABLE IF EXISTS $tableBills');
  }

  Future<int> deleteBill(String id) async {
    int result =
        await _db.delete(tableBills, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<List<Participant>> getParticipants(Bill bill) async {
    Database db = await instance.database;

    try {
      List<Map<String, dynamic>> participantList = await db.query(
          tableParticipants,
          where: "$colPbillId = ?",
          whereArgs: [bill.id]);

      List<Participant> participants = [];

      participantList.forEach((element) {
        participants.add(Participant.fromMap(element));
      });
      print(participants);

      return participants;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<Bill>> getBills() async {
    Database db = await instance.database;
    // var result = await db.query(tableBills);
    // print(result);
    try {
      List<Map<String, dynamic>> billList = await db.query(tableBills);
      List<Bill> bills = [];

      billList.forEach((element) {
        bills.add(Bill.fromMap(element));
      });

      return bills;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}

import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qrscanner/models/scan_model.dart';
export 'package:qrscanner/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database?> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) { },
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans (
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          );
        ''');
      }
    );
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final id    = newScan.id;
    final type  = newScan.type;
    final value = newScan.value;

    // Obtenemos la base de datos
    final db = await database;

    // Insertamos datos en la base de datos a traves de un query SQL
    final result = await db.rawInsert('''
      INSERT INTO Scans(id, type, value)
      VALUES('$id', '$type', '$value');
    ''');

    return result;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    // Insertamos un registro en la base de datos mediante el mapa del modelo que se genera a traves del toJson
    final result = await db.insert('Scans', newScan.toJson());
    return result;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;

    final res = await db.query(
      'Scans', 
      where: 'id = ?',
      whereArgs: [id]
    );

    return (res.isNotEmpty) 
      ? ScanModel.fromJson(res.first)
      : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return (res.isNotEmpty) 
      ? res.map((s) => ScanModel.fromJson(s)).toList()
      : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE type='$type';
    ''');

    return (res.isNotEmpty) 
      ? res.map((s) => ScanModel.fromJson(s)).toList()
      : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;

    /* Para hacer modificaciones tambien existe el metodo rawUpdate donde se especifica todo el query */
    final result = await db.update(
      'Scans', 
      newScan.toJson(), 
      where: 'id = ?', 
      whereArgs: [newScan.id]
    );

    return result;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;

    final result = await db.delete(
      'Scans', 
      where: 'id = ?', 
      whereArgs: [id]
    );

    return result;
  }

  Future<int> deleteAllScan() async {
    final db = await database;

    final result = await db.rawDelete('''
      DELETE FROM Scans;
    ''');

    return result;
  }
}

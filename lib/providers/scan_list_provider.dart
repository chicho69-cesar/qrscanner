import 'package:flutter/material.dart';

import 'package:qrscanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(type: selectedType, value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final allScans = await DBProvider.db.getAllScans();
    scans = [...allScans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scansByType = await DBProvider.db.getScansByType(type);
    scans = [...scansByType];
    selectedType = type;
    notifyListeners();
  }

  deleteById(int id) async {
    await DBProvider.db.deleteScan(id);
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }
}

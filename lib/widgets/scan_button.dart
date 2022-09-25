import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);
        // String barcodeScanRes = 'https://fernando-herrera.com';
        // String barcodeScanRes = 'geo:21.680014630207385,-102.58531298768702';

        if (barcodeScanRes == '-1') {
          return;
        }

        // ignore: use_build_context_synchronously
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes);

        // ignore: use_build_context_synchronously
        launch(context, newScan);
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus)
    );
  }
}

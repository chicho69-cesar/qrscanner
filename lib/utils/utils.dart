import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:qrscanner/models/scan_model.dart';

Future<void> launch(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    if (!await launchUrl(Uri.parse(scan.value))) {
      throw 'Could not launch ${ scan.value }';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
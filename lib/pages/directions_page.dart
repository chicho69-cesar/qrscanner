import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';

class DirectionsPage extends StatelessWidget {
  const DirectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: true);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.home_outlined, color: Theme.of(context).primaryColor),
        title: Text(scans[i].value),
        subtitle: Text('${ scans[i].id }'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor),
        onTap: () => print(scans[i].id),
      )
    );
  }
}

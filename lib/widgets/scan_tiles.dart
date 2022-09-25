import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qrscanner/models/scan_model.dart';

import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/utils/utils.dart';
import 'package:qrscanner/widgets/empty_scans.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: true);
    final scans = scanListProvider.scans;

    return scans.isEmpty 
      ? const EmptyScans()
      : _ScansList(scans: scans, type: type);
  }
}

class _ScansList extends StatelessWidget {
  const _ScansList({
    Key? key,
    required this.scans,
    required this.type,
  }) : super(key: key);

  final List<ScanModel> scans;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).deleteById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            type == 'http' ? Icons.home_outlined : Icons.map,
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[i].value),
          subtitle: Text('${ scans[i].id }'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor),
          onTap: () => launch(_, scans[i]),
        ),
      )
    );
  }
}

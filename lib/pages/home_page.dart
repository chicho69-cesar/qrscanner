import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:qrscanner/pages/directions_page.dart';
import 'package:qrscanner/pages/maps_history_page.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/widgets/custom_navigatorbar.dart';
import 'package:qrscanner/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.delete_forever_rounded)
          )
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currentIndex = uiProvider.selectedMenuOption;

    switch (currentIndex) {
      case 0:
        return const MapsPage();
      case 1: 
        return const DirectionsPage();
      default:
        return const MapsPage();
    }
  }
}

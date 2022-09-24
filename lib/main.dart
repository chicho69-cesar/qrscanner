import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:qrscanner/pages/home_page.dart';
import 'package:qrscanner/pages/map_page.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'map' : (_) => const MapPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
          bottomNavigationBarTheme: const  BottomNavigationBarThemeData(selectedItemColor: Colors.deepPurple)
        ),
      ),
    );
  }
}

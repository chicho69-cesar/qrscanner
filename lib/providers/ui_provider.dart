import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOption = 1;

  // ignore: unnecessary_getters_setters
  int get selectedMenuOption {
    return _selectedMenuOption;
  }

  set selectedMenuOption(int i) {
    _selectedMenuOption = i;
    notifyListeners();
  }
}

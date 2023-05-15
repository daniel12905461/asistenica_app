// import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {

  // String _selectedMenuOpt = 'inicio';
  int _selectedMenuOpt = 0;

  // String get selectedMenuOpt {
  //   return this._selectedMenuOpt;
  // }
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  // set selectedMenuOpt( String i ) {
  //   this._selectedMenuOpt = i;
  //   notifyListeners();
  // }
  set selectedMenuOpt( int i ) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }

}

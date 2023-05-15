import 'package:flutter/material.dart';


class ChangeFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String password = '';
  String new_password = '';
  String confirm_password = '';


  bool _isLoading = false;
  bool _view_password = false;
  bool _view_new_password = false;
  bool _view_confirm_password = false;

  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool get view_password => _view_password;
  set view_password( bool value ) {
    _view_password = value;
    notifyListeners();
  }

  bool get view_new_password => _view_new_password;
  set view_new_password( bool value ) {
    _view_new_password = value;
    notifyListeners();
  }

  bool get view_confirm_password => _view_confirm_password;
  set view_confirm_password( bool value ) {
    _view_confirm_password = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}

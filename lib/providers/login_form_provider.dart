import 'package:flutter/material.dart';


class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email    = '';
  String password = '';

  bool _isLoading = false;
  bool _view_password = true;

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

  bool isValidForm() {

    print(formKey.currentState?.validate());

    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }

}

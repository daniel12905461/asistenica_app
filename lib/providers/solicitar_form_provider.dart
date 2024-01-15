import 'package:flutter/material.dart';


class SolicitarFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String _motivo = '';
  String index = '';

  bool _isLoading = false;
  bool _isVisible = false;

  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isVisible => _isVisible;
  set isVisible( bool value ) {
    _isVisible = value;
    notifyListeners();
  }

  String get motivo => _motivo;
  set motivo( String value ) {
    _motivo = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}

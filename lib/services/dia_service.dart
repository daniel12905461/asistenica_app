import 'dart:convert';
import 'dart:io';

import 'package:asistencia_app/models/models.dart';
import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';

import 'package:http/http.dart' as http;

class DiaService extends ChangeNotifier {

  final enviromentProvider = new EnviromentProvider();
  late Dia selectedDia;
  final List<Dia> dias = [];

  bool isLoading = true;
  // bool isSaving = false;
  final storage = new FlutterSecureStorage();

  DiaService() {
    this.listDia(Preferences.user.id!);
  }

  Future<List<Dia>> listDia(int id) async {

    this.isLoading = true;
    notifyListeners();

    print("DADasdasdasd");
    this.dias.clear();

    // final url = Uri.https(
    //   enviromentProvider.baseUrl,
    //   enviromentProvider.baseUrlAux + 'controls/controles_evento/' ,
    //   // {'q': '{https}'}
    // );
    final url = Uri.parse(enviromentProvider.baseUrl+'dias/funcionario/'+id.toString());


    // try {

      final resp = await http.get( url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        } );

      if (resp.statusCode != 200) throw HttpException('${resp.statusCode}');

      final List controlsMapAux = json.decode( resp.body )['data'];
      print(controlsMapAux);

      for (var i = 0; i < controlsMapAux.length; i++) {
        final tempControl = Dia.fromMap( controlsMapAux[i] );
        this.dias.add( tempControl );
      }

    // } on SocketException catch (error)  {
    //   NotificationsService.showSnackbar( 'No hay conexión a Internet', 'warning');
    // } on HttpException catch (error) {
    //   NotificationsService.showSnackbar( 'Error! '+error.toString(), 'error');
    // } on FormatException {
    //   NotificationsService.showSnackbar( 'Error! Formato de respuesta incorrecto', 'error');
    // } catch(error) {
    //   NotificationsService.showSnackbar( 'Error! ocurrió un error', 'error');
    // }

    this.isLoading = false;
    notifyListeners();

    return this.dias;

  }
}

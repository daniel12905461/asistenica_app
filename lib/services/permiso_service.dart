import 'dart:convert';
import 'dart:io';

import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/services/background_service.dart';
import 'package:asistencia_app/services/notifications_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PermisoService extends ChangeNotifier {

  final enviromentProvider = new EnviromentProvider();
  final backgroundService = new BackgroundService();

  final loading = true;

  Future<String> registrarPermiso( String motivo, String id) async {

    // final url = Uri.parse('http://'+enviromentProvider.baseUrl + enviromentProvider.baseUrlAux+'registrar');
    final url = Uri.parse(enviromentProvider.baseUrl+'permisos');

    String returnAux = 'No';

    // try {
      final resq = await http.MultipartRequest(
        'POST',
        url,
      );

      resq.fields['motivo'] = motivo;
      resq.fields['id_funcionarios'] = id;

      var resp = await resq.send();

      String responseBody = await resp.stream.bytesToString();

      Map<String, dynamic> decodedResp = json.decode(responseBody);

      print(decodedResp);

      if ( decodedResp['ok'] ) {

        NotificationsService.showSnackbar(decodedResp['mensaje'], 'success');
        returnAux = 'Si';

      } else {

        NotificationsService.showSnackbar( decodedResp['mensaje'], 'error');
        returnAux = 'No';

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

    return returnAux;
  }

}

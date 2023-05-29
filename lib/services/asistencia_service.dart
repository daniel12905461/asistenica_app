import 'dart:convert';
import 'dart:io';

// import 'package:asistencia_app/models/models.dart';
import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/services/notifications_service.dart';
// import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class AsistenciaService extends ChangeNotifier {

  final enviromentProvider = new EnviromentProvider();

  final loading = true;

  Future<String> registrarAsistencia( String imagePath, String name, int id) async {

    // final url = Uri.parse('http://'+enviromentProvider.baseUrl + enviromentProvider.baseUrlAux+'registrar');
    final url = Uri.parse(enviromentProvider.baseUrl+'asistencia/registrar');

    String returnAux = 'No';

    try {
      final resq = await http.MultipartRequest(
        'POST',
        url,
      );

      final file = await http.MultipartFile.fromPath('image', imagePath);
      resq.files.add(file);
      resq.fields['name'] = name;
      resq.fields['id'] = id.toString();
      resq.fields['latitud'] = id.toString();
      resq.fields['longitud'] = id.toString();

      var resp = await resq.send();

      String responseBody = await resp.stream.bytesToString();

      Map<String, dynamic> decodedResp = json.decode(responseBody);

      if ( decodedResp['ok'] ) {

        NotificationsService.showSnackbar(decodedResp['mensaje'], 'success');
        returnAux = 'Si';

      } else {
        NotificationsService.showSnackbar( decodedResp['mensaje'], 'error');
        returnAux = 'No';
      }

    } on SocketException catch (error)  {
      NotificationsService.showSnackbar( 'No hay conexión a Internet', 'warning');
    } on HttpException catch (error) {
      NotificationsService.showSnackbar( 'Error! '+error.toString(), 'error');
    } on FormatException {
      NotificationsService.showSnackbar( 'Error! Formato de respuesta incorrecto', 'error');
    } catch(error) {
      NotificationsService.showSnackbar( 'Error! ocurrió un error', 'error');
    }

    return returnAux;
  }

  Future<String> verificarAsistencia( String imagePath, String name, int id) async {

    final url = Uri.parse(enviromentProvider.baseUrl+'asistencia/login');

    String returnAux = 'No';

    try {
      final resq = await http.MultipartRequest(
        'POST',
        url,
      );

      double latitud = 0.0;
      double longitud = 0.0;
      bool servicioActivo = await Geolocator.isLocationServiceEnabled();
      if (servicioActivo) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latitud = position.latitude;
        longitud = position.longitude;
        // Aquí puedes hacer lo que necesites con las variables latitud y longitud
        print('Latitud: $latitud, Longitud: $longitud');
      } else {
      //   // El servicio de ubicación está desactivado en el dispositivo
      //   // Puedes mostrar un mensaje o pedir al usuario que habilite la ubicación
      }

      final file = await http.MultipartFile.fromPath('image', imagePath);
      resq.files.add(file);
      resq.fields['name'] = name;
      resq.fields['id'] = id.toString();
      resq.fields['latitud'] = latitud.toString();
      resq.fields['longitud'] = longitud.toString();

      var resp = await resq.send();

      String responseBody = await resp.stream.bytesToString();

      Map<String, dynamic> decodedResp = json.decode(responseBody);

      if ( decodedResp['ok'] ) {

        NotificationsService.showSnackbar(decodedResp['mensaje'], 'success');
        returnAux = 'Si';

      } else {
        NotificationsService.showSnackbar( decodedResp['mensaje'], 'error');
        returnAux = 'No';
      }

    } on SocketException catch (error)  {
      NotificationsService.showSnackbar( 'No hay conexión a Internet', 'warning');
    } on HttpException catch (error) {
      NotificationsService.showSnackbar( 'Error! '+error.toString(), 'error');
    } on FormatException {
      NotificationsService.showSnackbar( 'Error! Formato de respuesta incorrecto', 'error');
    } catch(error) {
      NotificationsService.showSnackbar( 'Error! ocurrió un error', 'error');
    }

    return returnAux;
  }
}

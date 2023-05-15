import 'dart:convert';
import 'dart:io';

import 'package:asistencia_app/models/models.dart';
import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/services/notifications_service.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final enviromentProvider = new EnviromentProvider();

  final storage = new FlutterSecureStorage();

  Future<String> login( String email, String password ) async {

    // final url = Uri.http(
    //   enviromentProvider.baseUrl, enviromentProvider.baseUrlAux+'auth/login'
    // );
    final url = Uri.parse(enviromentProvider.baseUrl+'auth/login');


    String returnAux = 'No';

    try {

      Map<String, dynamic> data = {
        'user': email,
        'password': password,
      };

      String jsonData = jsonEncode(data);

      final resp = await http.post(
        url,
        // Uri.parse('http://'+enviromentProvider.baseUrl + enviromentProvider.baseUrlAux+'auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData
      );

      final Map<String, dynamic> decodedResp = json.decode( resp.body );

      // print(json.decode( resp.body ));

      if ( decodedResp['ok'] ) {
        await storage.write(key: 'token', value: decodedResp['token']);

        if(!decodedResp['data'].isEmpty) Preferences.user = User.fromMap(decodedResp['data']);

        // List<Rol> roles = [];
        // for (var i = 0; i < decodedResp['roles'].length; i++) {
        //   roles.add( Rol.fromMap(decodedResp['roles'][i]) );
        // }
        // Preferences.roles = roles;
        // Preferences.rolesItems = ['Dconfiguracion'];

        returnAux = 'Si';

        NotificationsService.showSnackbar('Bienvenido!', 'success');

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

  Future logout() async {
    await storage.delete(key: 'token');
    // Preferences.member = Member();
    // await storage.delete(key: 'member');
    return;
  }

  Future<String> readToken() async {

    return await storage.read(key: 'token') ?? '';

  }

  Future<String> changePassword( String password, String new_password, String user_id ) async {

    final url = Uri.https(
      enviromentProvider.baseUrl,
      enviromentProvider.baseUrlAux + 'users/change_password/' + user_id,
      // { 'key': _firebaseToken }
    );

    String res = 'No';

    try {

      final resp = await http.post(
        url,
        body: {
          'password': password,
          'new_password': new_password,
        }
      );

      if (resp.statusCode == 409){
        NotificationsService.showSnackbar(json.decode( resp.body )['message'], 'warning');
        return 'No';
      }

      if (resp.statusCode != 201) throw HttpException('${resp.statusCode}');

      res = 'Si';

      NotificationsService.showSnackbar(json.decode( resp.body )['message'].toString(), 'success');

    } on SocketException catch (error)  {
      NotificationsService.showSnackbar( 'No hay conexión a Internet', 'warning');
    } on HttpException catch (error) {
      NotificationsService.showSnackbar( 'Error! '+error.toString(), 'error');
    } on FormatException {
      NotificationsService.showSnackbar( 'Error! Formato de respuesta incorrecto', 'error');
    }
    // catch(error) {
    //   NotificationsService.showSnackbar( 'Error! ocurrió un error', 'error');
    // }

    return res;

  }

}

import 'dart:async';
import 'dart:convert';

import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class BackgroundServicecdsdsd {

  Timer? locationTimer;

  final enviromentProvider = new EnviromentProvider();

  void startLocationUpdates() {
    // Cancelar cualquier temporizador existente para evitar duplicaciones
    stopLocationUpdates();

    // Iniciar un temporizador para ejecutar la función cada 5 segundos
    locationTimer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      updateLocationAndSendToBackend();
    });
  }

  void stopLocationUpdates() {
    locationTimer?.cancel();
    locationTimer = null;
  }

  void updateLocationAndSendToBackend() async {
    try {

      double latitud = 0.0;
      double longitud = 0.0;
      bool servicioActivo = await Geolocator.isLocationServiceEnabled();
      if (servicioActivo) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latitud = position.latitude;
        longitud = position.longitude;
        // Aquí puedes hacer lo que necesites con las variables latitud y longitud
        print('Latitud: $latitud, Longitud: $longitud');


        final url = Uri.parse(enviromentProvider.baseUrl+'ubicacion-horas');

        final resq = await http.MultipartRequest(
          'POST',
          url,
        );

        // resq.fields['id'] = '';
        // resq.fields['hora'] = '00:00:00';
        resq.fields['latitud'] = latitud.toString();
        resq.fields['longitud'] = longitud.toString();
        resq.fields['id_dia'] = Preferences.idDia;

        var resp = await resq.send();
        String responseBody = await resp.stream.bytesToString();

        Map<String, dynamic> decodedResp = json.decode(responseBody);
      }

    } catch (e) {
      // Manejar errores en la obtención de la ubicación o el envío al backend
      print('Error: $e');
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class BackgroundService {
  Isolate? _isolate;

  void startIsolate() async {
    // Verificar si el isolate ya está en ejecución
    if (_isolate != null) return;

    // Crear un ReceivePort para recibir mensajes desde el isolate
    ReceivePort receivePort = ReceivePort();

    // Iniciar el isolate
    _isolate = await Isolate.spawn(
      updateLocationAndSendToBackend,
      receivePort.sendPort,
    );

    // Escuchar mensajes enviados desde el isolate
    receivePort.listen((message) {
      // Manejar los mensajes recibidos desde el isolate, si es necesario
    });
  }

  void stopIsolate() {
    // Terminar y eliminar el isolate
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }

  static void updateLocationAndSendToBackend(SendPort sendPort) async {
    Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      try {
        final enviromentProvider = EnviromentProvider();
        double latitud = 0.0;
        double longitud = 0.0;
        bool servicioActivo = await Geolocator.isLocationServiceEnabled();
        if (servicioActivo) {
          Position position =
              await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          latitud = position.latitude;
          longitud = position.longitude;
          // Aquí puedes hacer lo que necesites con las variables latitud y longitud
          print('Latitud: $latitud, Longitud: $longitud');

          final url = Uri.parse(enviromentProvider.baseUrl + 'ubicacion-horas');

          final resq = await http.MultipartRequest(
            'POST',
            url,
          );

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
    });
  }
}

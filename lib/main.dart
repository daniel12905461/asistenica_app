// import 'dart:_http';
import 'dart:async';
import 'dart:io';

// import 'package:app_gasto_diario/services/eventos_config_service.dart';
import 'package:asistencia_app/providers/loading_provider.dart';
import 'package:asistencia_app/services/notifications_service.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asistencia_app/screens/screens.dart';
import 'package:asistencia_app/services/services.dart';

import 'providers/ui_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'dart:isolate';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  await Preferences.init();

  await Permission.location.request();

  await Future.delayed(Duration.zero);

  runApp( AppState() );

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Utiliza latitud y longitud como desees
  print("Latitud: ${position.latitude}");
  print("Longitud: ${position.longitude}");

  // Ejecutar el método en segundo plano
  _runInBackground();
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return MyApp();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => new UiProvider() ),
        ChangeNotifierProvider(create: ( _ ) => AsistenciaService()),
        ChangeNotifierProvider(create: ( _ ) => LoadingProvider()),
        ChangeNotifierProvider(create: ( _ ) => DiaService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      initialRoute: 'checking',
      routes: {
        'checking': ( _ ) => CheckAuthScreen(),

        'home': ( _ ) => HomeScreen(),
        'asistencia': ( _ ) => AsistenciaSreen(),
        // 'img': ( _ ) => ImgScreen(imagePath: "",title: "",type: 0,),

        'login': ( _ ) => LoginScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      // theme: ThemeData.light().copyWith(
      //   scaffoldBackgroundColor: Colors.grey[300],
      //   appBarTheme: AppBarTheme(
      //     elevation: 0,
      //     color: Colors.indigo
      //   ),
      //   floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     backgroundColor: Colors.indigo,
      //     elevation: 0
      //   )
      // ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          // color: Colors.grey[100],
          color: Colors.white,
          // textTheme: TextTheme(
          //   title: TextStyle(
          //     color: Colors.lightBlue[900],
          //     fontWeight: FontWeight.w600,
          //     fontSize: 17.0
          //   )
          // ),
          titleTextStyle: TextStyle(
            color: Colors.lightBlue[900],
            fontWeight: FontWeight.w600,
            fontSize: 17.0
          ),
          iconTheme: IconThemeData(
            color: Colors.lightBlue[900]
          )
        ),
        // scaffoldBackgroundColor: Colors.grey[100],
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.lightBlue[800],
        // navigationRailTheme: NavigationRailThemeData(
        //   backgroundColor: Colors.indigo,
        //   elevation: 2
        // )
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> _runInBackground() async {

  // Crea un nuevo `Isolate`
  Isolate.spawn(_backgroundFunction, 'Hola desde el fondo');
}

void _backgroundFunction(dynamic message) {
  // Este es el código que se ejecuta en segundo plano
  // print('Mensaje recibido en segundo plano: $message');
  Timer.periodic(Duration(seconds: 5), (timer) {
    // Este es el código que se ejecuta cada segundo en segundo plano
    print('Ejecutando cada segundo en segundo plano');
    // _requestLocationPermission();
  });
}

// void _requestLocationPermission() async {
//   var status = await Permission.location.request();
//   if (status.isGranted) {
//     print('Permisos de ubicación concedidos');
//   } else {
//     print('Permisos de ubicación denegados');
//   }
// }

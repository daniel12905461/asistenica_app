// import 'dart:_http';
// import 'dart:async';
import 'dart:io';

// import 'package:app_gasto_diario/services/eventos_config_service.dart';
import 'package:asistencia_app/providers/loading_provider.dart';
import 'package:asistencia_app/services/notifications_service.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asistencia_app/screens/screens.dart';
import 'package:asistencia_app/services/services.dart';

import 'providers/ui_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:permission_handler/permission_handler.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  await Preferences.init();

  // await Permission.location.request();

  await Future.delayed(Duration.zero);

  runApp( AppState() );

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
        'perfil': ( _ ) => PerfilScreen(),
        'solicitar': ( _ ) => SolicitarScreen(),

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

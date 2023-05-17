import 'dart:io';
import 'package:asistencia_app/providers/loading_provider.dart';
import 'package:asistencia_app/screens/asistencia_screen.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:asistencia_app/services/asistencia_service.dart';
import 'package:provider/provider.dart';

class ImgScreen extends StatelessWidget {

  final String imagePath;
  final String title;
  final int type;

  const ImgScreen({Key? key, required this.imagePath, required this.title, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final asistenciaService = Provider.of<AsistenciaService>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(imagePath)),
          // ElevatedButton(
          //   onPressed: () async {
          //     if(type == 1){
          //       await asistenciaService.registrarAsistencia(imagePath, Preferences.user.nombres.toString(), Preferences.user.id!);
          //     }else{
          //       await asistenciaService.verificarAsistencia(imagePath, Preferences.user.nombres.toString(), Preferences.user.id!);
          //     }
          //     // AsistenciaSreen();
          //     Navigator.pushNamed(context, 'asistencia');
          //   },
          //   child: Text("Enviar"),
          // ),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            // color: Colors.deepPurple,
            color: Colors.lightBlue[900],
            child: Container(
              padding: EdgeInsets.symmetric( horizontal: 50, vertical: 15),
              child: Text(
                loadingProvider.isLoading
                  ? 'Espere...'
                  : 'Enviar',
                style: TextStyle( color: Colors.white ),
              )
            ),
            onPressed: loadingProvider.isLoading ? null : () async {

              loadingProvider.isLoading = true;

              if(type == 1){
                await asistenciaService.registrarAsistencia(imagePath, Preferences.user.nombres.toString(), Preferences.user.id!);
              }else{
                await asistenciaService.verificarAsistencia(imagePath, Preferences.user.nombres.toString(), Preferences.user.id!);
              }

              loadingProvider.isLoading = false;

              Navigator.pushReplacementNamed(context, 'asistencia');
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AsistenciaSreen(),
              //   ),
              // );
            }
          )
        ],
      ),
    );
  }
}

import 'dart:io';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(imagePath)),
          ElevatedButton(
            onPressed: () async {
              if(type == 1){
                await asistenciaService.registrarAsistencia(imagePath, Preferences.user.nombres.toString(), Preferences.user.id!);
              }else{
                await asistenciaService.verificarAsistencia(imagePath, Preferences.user.nombres.toString(), Preferences.user.id!);
              }
              // AsistenciaSreen();
              Navigator.pushNamed(context, 'asistencia');
            },
            child: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}

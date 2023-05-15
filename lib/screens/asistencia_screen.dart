import 'dart:io';
import 'dart:math';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asistencia_app/screens/screens.dart';

class AsistenciaSreen extends StatelessWidget {

  Future<void> _takePicture(BuildContext context, title, type) async {
    final picker = ImagePicker();
    // final image = await picker.getImage(source: ImageSource.camera,
    // // preferredCameraDevice: CameraDevice.front
    // );
    final image = await picker.pickImage(
      source: ImageSource.camera, // La fuente de la imagen será la cámara
      preferredCameraDevice: CameraDevice.rear // Especificamos la cámara frontal como predeterminada
    );

    if (image != null) {
      // Navega a la pantalla de vista previa de la imagen capturada
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImgScreen(imagePath: image.path, title: title, type: type)),
      );

      // Navigator.pushNamed(context, 'img',arguments: {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(children: [
            Text(
              'APP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Funcionario: ' + Preferences.user.nombres.toString() + ' ' + Preferences.user.apellidos.toString(),
              style: TextStyle(
                fontSize: 15
              ),
            ),
          ],),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.upload_file_outlined),
              onPressed: () {
                _takePicture(context, 'Registrar Imagen', 1);
              },
            ),
          ],
        ),
        body: Column(
            children: [
              // Text('Desarrollado por Initt Soft')
            ],
          ),
          floatingActionButton: Visibility(
            visible: true,
            child: FloatingActionButton(
              elevation: 0,
              child: Icon(Icons.more_time),
              onPressed: () async {
                _takePicture(context, 'Login', 2);
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}

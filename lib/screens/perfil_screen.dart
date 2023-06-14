import 'package:asistencia_app/screens/img_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';

class PerfilScreen extends StatelessWidget {

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

  final enviromentProvider = new EnviromentProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 4,
                ),
              ),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  // 'http://192.168.0.14:8000/public/1_daniel.jpg', // URL de la imagen
                  enviromentProvider.baseUrl+'public/'+Preferences.user.id.toString()+'_'+Preferences.user.nombres.toString()+'.jpg',  // URL de la imagen
                ),
              ),
            ),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Acción al presionar el botón
            //   },
            //   child: Text('Actualizar imagen'),
            // ),
            MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            // color: Colors.deepPurple,
            color: Colors.lightBlue[900],
            child: Container(
              padding: EdgeInsets.symmetric( horizontal: 50, vertical: 15),
              child: Text('Actualizar imagen',
                style: TextStyle( color: Colors.white ),
              )
            ),
            onPressed: () async {
              _takePicture(context, 'Registrar Imagen', 1);
            }
          )
          ],
        ),
      ),
    );
  }
}

import 'package:asistencia_app/screens/screens.dart';
import 'package:asistencia_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ConfiguracionScreen extends StatelessWidget {

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

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configuracion'),
      ),

      body: Column(
        children: <Widget> [
          Expanded( child:
            ListView( children: [
              ListTile(
                title: Text('Cerrar Sesión'),
                // subtitle: Text('Cerrar Sesión'),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () async {
                  return showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text('Desea cerrar sesión?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Cancelar', style: TextStyle(color: Colors.red))
                        ),
                        TextButton(
                          onPressed: () async {
                            await authService.logout();
                            Navigator.pushReplacementNamed(context, 'login');
                            // Navigator.of(context).pop(false);
                          },
                          child: Text('Aceptar')
                        ),
                      ],
                    )
                  );
                },
              ),
              ListTile(
                title: Text('Cambiar contraseña'),
                // subtitle: Text('cambiar la contraseña de su cuenta'),
                leading: Icon(Icons.lock_outline),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
                onTap: (){
                  // print('sdfsdf');
                  Navigator.pushNamed(context, 'change');
                },
              ),
              ListTile(
                title: Text('Registrar Imagen'),
                // subtitle: Text('cambiar la contraseña de su cuenta'),
                leading: Icon(Icons.image),
                trailing: Icon(Icons.keyboard_arrow_right_outlined),
                onTap: (){
                  // print('sdfsdf');
                  _takePicture(context, 'Registrar Imagen', 1);
                },
              )
            ])
          )
        ]
      )

    );
  }
}

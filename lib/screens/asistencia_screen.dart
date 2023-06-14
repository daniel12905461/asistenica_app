import 'dart:async';

import 'package:asistencia_app/providers/enviroment_provider.dart';
import 'package:asistencia_app/services/background_service.dart';
import 'package:asistencia_app/services/dia_service.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:asistencia_app/widgets/dia_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asistencia_app/screens/screens.dart';
import 'package:provider/provider.dart';

class AsistenciaSreen extends StatelessWidget {

  final BackgroundService backgroundTask = BackgroundService();

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

    final diaService = Provider.of<DiaService>(context);
    final enviromentProvider = new EnviromentProvider();

    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
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
            // IconButton(
            //   icon: Icon(Icons.upload_file_outlined),
            //   onPressed: () {
            //     _takePicture(context, 'Registrar Imagen', 1);
            //   },
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'perfil');
                    },
                    child: Image.network(
                      enviromentProvider.baseUrl+'public/'+Preferences.user.id.toString()+'_'+Preferences.user.nombres.toString()+'.jpg',  // URL de la imagen
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            diaService.listDia(Preferences.user.id!);
          },
          child: (!diaService.isLoading) ? ListView.builder(
            itemCount: diaService.dias.length,
            itemBuilder: ( BuildContext context, int index ) => GestureDetector(//detecta el click
              onTap: () async {

                // diaService.selectedControl = controlesService.controls[index].copy();
                // Loader.show(
                //   context,
                //   progressIndicator: CircularProgressIndicator(),
                //   overlayColor: Color(0x99E8EAF6)
                // );
                // await asistenciaService.listAsistenciaControl('',controlesService.selectedControl.id!);
                // // monthsService.listaMeses();
                // Loader.hide();
                // Navigator.pushNamed(context, 'asistencia');

                return showDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: Text('Desea registrar la Hora?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Cancelar', style: TextStyle(color: Colors.red))
                      ),
                      TextButton(
                        onPressed: () async {
                          // print(diaService.dias[index].fecha);
                          _takePicture(context, 'Registrar Hora de Asistencia', 2);
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Aceptar')
                      ),
                    ],
                  )
                );
              },
              child: DiaCard(
                dia: diaService.dias[index],
                // evento: eventosService.selectedEvento,
              ),
            )
          ) : Center(
            child: CircularProgressIndicator()
          ),
        ),
        floatingActionButton: Visibility(
          visible: true,
          child: FloatingActionButton(
            backgroundColor: Colors.lightBlue[800],
            elevation: 0,
            child: Icon(Icons.more_time),
            onPressed: () async {
              _takePicture(context, 'Registrar Hora de Asistencia', 2);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}

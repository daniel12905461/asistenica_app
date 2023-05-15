import 'package:flutter/material.dart';

class InittScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: Text('OTB - Villa Aurora'),
          title: Column(
            children: [
              Text(
                'Mi OTB',
                // Preferences.setting.nombre!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50),
          // padding: EdgeInsetsGeometry.infinity,
          child: Column(
            children: <Widget>[
              Text('Desarrollado por Initt Soft'),
              Text('Bienvenido a la app Mi OTB!',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 20)),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.up,
          ),
        ));
  }
}

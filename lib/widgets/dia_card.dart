import 'package:asistencia_app/services/services.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:asistencia_app/models/models.dart';
// import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class DiaCard extends StatelessWidget {

  final Dia? dia;
  // final Evento? evento;

  const DiaCard({
    Key? key,
    this.dia,
    // this.evento
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        // margin: EdgeInsets.only( top: 30, bottom: 50 ),
        width: double.infinity,
        // height: 75,
        // decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft, //alinear abajo
          children: [

            // _BackgroundImage( product.picture ),

            _DiaDetails(//si esta disponiible el nombre
              nombre: dia!.nombre,
              fecha: dia!.fecha,
              horaInicio: dia!.horaInicio,
              horaFinReseso: dia!.horaFinReseso,
              horaInicioReseso: dia!.horaInicioReseso,
              horaFin: dia!.horaFin,
            ),

          ],
        ),
      ),
    );
  }
}

class _DiaDetails extends StatelessWidget {

  final String? nombre;
  final dynamic fecha;
  final dynamic horaInicio;
  final dynamic horaFinReseso;
  final dynamic horaInicioReseso;
  final dynamic horaFin;

  const _DiaDetails({
    this.nombre,
    this.fecha,
    this.horaInicio,
    this.horaFinReseso,
    this.horaInicioReseso,
    this.horaFin
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only( right: 0 ), //separacion de la isquierda
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 3, vertical: 3 ),
        width: double.infinity,
        // height: 110,
        // decoration: _buildBoxDecoration(),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          // color: Colors.blueGrey[100],
          // color: activo == 1 ? Colors.red[200] : Colors.blue[200],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
        ),
        child: Column(
          children: [
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow( children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Icon(
                        Icons.circle,
                        color: Colors.tealAccent[700],
                      ),
                    ]
                  ),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 0, vertical: 6 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          nombre!,
                          style: TextStyle( fontSize: 20, color: Colors.lightBlue[900], fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        // 'fecha: '+fecha,
                        fecha+'',
                        style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]
                  ),
                ])
              ]
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow( children: [
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 0, vertical: 6 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hr. Entrada:',
                          style: TextStyle( fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          horaInicio!,
                          style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 0, vertical: 6 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hr. Sal. Des.:',
                          style: TextStyle( fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          horaFinReseso!,
                          style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 0, vertical: 6 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hr. Ent. Des.:',
                          style: TextStyle( fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          horaInicioReseso!,
                          style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 0, vertical: 6 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hr. Salida:',
                          style: TextStyle( fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          horaFin!,
                          style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ],
        )

      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.blue[200],
    // color: Colors.red[200],
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
      topRight: Radius.circular(10),
      topLeft: Radius.circular(10),
    )
  );
}

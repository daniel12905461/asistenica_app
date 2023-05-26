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
              fecha: dia!.fecha
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

  const _DiaDetails({
    this.nombre,
    this.fecha
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only( right: 0 ), //separacion de la isquierda
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20, vertical: 3 ),
        width: double.infinity,
        // height: 70,
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
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(6),
            2: FlexColumnWidth(4),
            // 3: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow( children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Icon(
                    Icons.circle,
                    color: Colors.tealAccent[700],
                  ),
                ]
              ),
              Container(
                padding: EdgeInsets.symmetric( horizontal: 0, vertical: 12 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre!,
                      style: TextStyle( fontSize: 20, color: Colors.lightBlue[900], fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'fecha: '+fecha,
                      // 'cant.: 1000',
                      style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children:[
              //     Text(
              //       'fecha.: '+fecha,
              //       // 'cant.: 1000',
              //       style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400),
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //   ]
              // ),


            ]),
          ],
        ),
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

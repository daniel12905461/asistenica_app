import 'package:flutter/material.dart';

class NotificationsService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, String state){

    final snackBar = new SnackBar(

      // content: Text(
      //   message,
      //   style: TextStyle(
      //     color: state == 'success' ? Colors.grey[700] : state == 'warning' ? Colors.grey[700]: Colors.white,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 15,
      //   ),
      // ),
      content:
      Table(
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(8),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [

              Column(
                children: [
                  Icon(
                    // Icons.check,
                    state == 'success' ? Icons.done : state == 'warning' ? Icons.warning_amber_rounded : Icons.error_outline,
                    color: state == 'success' ? Colors.teal[600] : state == 'warning' ? Color.fromARGB(255, 255, 208, 0): Colors.red[600],
                  ),
                ],
              ),
              // Text(' '),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: state == 'success' ? Colors.teal[600] : state == 'warning' ? Color.fromARGB(255, 255, 208, 0): Colors.red[600],
                      fontWeight: FontWeight.bold,
                      // fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      backgroundColor: state == 'success' ? Colors.teal[50] : state == 'warning' ? Colors.yellow[100] : Colors.red[50],

    );

    messengerKey.currentState!.showSnackBar(snackBar);

  }

}

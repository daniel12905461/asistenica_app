import 'package:flutter/material.dart';


class InputDecorations {

  static InputDecoration authInputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            // color: Colors.deepPurple
            color: Colors.blue
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            // color: Colors.deepPurple,
            color: Colors.blue,
            // width: 2
          )
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey
        ),
        prefixIcon: prefixIcon != null
          ? Icon(
            prefixIcon,
            // color: Colors.deepPurple
            color: Colors.lightBlue[900]
          )
          : null,
        // suffixIcon: 'Contraseña' == labelText ? Icon( Icons.remove_red_eye_outlined ) : null,
      );
  }

}

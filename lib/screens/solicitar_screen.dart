import 'package:asistencia_app/providers/solicitar_form_provider.dart';
import 'package:asistencia_app/services/permiso_service.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
// import 'package:asistencia_app/services/permiso_service.dart';
import 'package:flutter/material.dart';
// import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

class SolicitarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar permiso para Hoy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: ( _ ) => SolicitarFormProvider(),
          child: _ChangeForm()
        ),
      )
    );
  }
}

class _ChangeForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final solicitarForm = Provider.of<SolicitarFormProvider>(context);
    // final permisoService = Provider.of<PermisoService>(context, listen: false);

    return Form(
      key: solicitarForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Motivo:"
            ),
            validator: (value){
              return ( value != null && value.length >= 1 )
                ? null
                : 'Este campo es obligatorio';
            },
            onChanged: ( value ) => solicitarForm.motivo = value,
          ),
          SizedBox( height: 10 ),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.lightBlue[900],
            child: Container(
              padding: EdgeInsets.symmetric( horizontal: 90, vertical: 15),
              child: Text(
                solicitarForm.isLoading
                  ? 'Espere...'
                  : 'Enviar',
                style: TextStyle( color: Colors.white, fontSize: 17),
              )
            ),
            onPressed: solicitarForm.isLoading ? null : () async{

              FocusScope.of(context).unfocus();
              final permisoService = Provider.of<PermisoService>(context, listen: false);

              if( !solicitarForm.isValidForm() ) return;

              solicitarForm.isLoading = true;
              
              String res = await permisoService.registrarPermiso(solicitarForm.motivo, Preferences.user.id.toString());

              solicitarForm.isLoading = false;
              
              // diaService.listDia(Preferences.user.id!);

              // Navigator.of(context).pop(true);
              if(res == 'Si') Navigator.of(context).pop(true);

            }
          ),
        ],
      ),
    );
  }
}

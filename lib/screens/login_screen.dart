import 'package:asistencia_app/providers/login_form_provider.dart';
import 'package:asistencia_app/providers/ui_provider.dart';
import 'package:asistencia_app/services/services.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:asistencia_app/ui/input_decorations.dart';
import 'package:asistencia_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // SizedBox(
              //   // height: 250,
              //   height: 180,
              //   // height: double.infinity,
              // ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * .3, 0,0),
                child: CardContainer(
                  child: Column(
                    children: [

                      SizedBox( height: 10 ),
                      Text(
                        'Iniciar Sesión',
                        // style: Theme.of(context).textTheme.headline4,
                        style: TextStyle(fontSize: 20, color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                      SizedBox( height: 10 ),


                      ChangeNotifierProvider(
                        create: ( _ ) => LoginFormProvider(),
                        child: _LoginForm()
                      )

                    ],
                  )
                ),
              ),

              SizedBox( height: 50 ),
              // TextButton(
              //   onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
              //   style: ButtonStyle(
              //     overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
              //     shape: MaterialStateProperty.all(StadiumBorder())
              //   ),
              //   child: Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, color: Colors.black87 ),),
              // ),
              // SizedBox( height: 50 ),

            ],
          ),
        )
      ),
    );
  }
}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Usuario",
                hintText: 'Usuario',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.lightBlue[900]
                ),
              ),
              onChanged: ( value ) => loginForm.email = value,
              // validator: ( value ) {

              //   String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              //   RegExp regExp  = new RegExp(pattern);

              //   return regExp.hasMatch(value ?? '')
              //     ? null
              //     : 'El valor ingresado no luce como un correo';

              // },
              validator: ( value ) {

                  return ( value != null && value.length >= 1 )
                    ? null
                    : 'El campo Usuario es obligatorio';

              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: loginForm.view_password,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Contraseña",
                hintText: '******',
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.lightBlue[900]
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    loginForm.view_password
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye
                  ),
                  onPressed: () {
                    if(loginForm.view_password){
                      loginForm.view_password = false;
                    }else{
                      loginForm.view_password = true;
                    }
                  },
                )
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) {

                  return ( value != null && value.length >= 1 )
                    ? null
                    : 'El campo Contraseña es obligatorio';

              },
            ),

            SizedBox( height: 30 ),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              // color: Colors.deepPurple,
              color: Colors.lightBlue[900],
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                    ? 'Espere...'
                    : 'Ingresar',
                  style: TextStyle( color: Colors.white ),
                )
              ),
              onPressed: loginForm.isLoading ? null : () async {

                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if( !loginForm.isValidForm() ) return;

                loginForm.isLoading = true;

                final String errorMessage = await authService.login(loginForm.email, loginForm.password);

                if ( errorMessage == 'Si' || errorMessage == 'Op') {

                  // final parcelsMemberServiceAux = Provider.of<ParcelsMemberService>(context, listen: false);
                  // if (errorMessage == 'Op') parcelsMemberServiceAux.listParcel();
                  // parcelsMemberServiceAux.listRoles();
                  // parcelsMemberServiceAux.listRolesItems();

                  // Provider.of<UiProvider>(context, listen: false).selectedMenuOpt = Preferences.rolesItems[0];

                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  print( errorMessage );
                  // NotificationsService.showSnackbar( 'No hay conexión a Internet', 'warning');
                  loginForm.isLoading = false;
                }
              }
            )

          ],
        ),
      ),
    );
  }
}

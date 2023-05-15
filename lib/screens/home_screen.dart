import 'package:asistencia_app/providers/ui_provider.dart';
import 'package:asistencia_app/screens/screens.dart';
import 'package:asistencia_app/widgets/custom_navigatorbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _HomePageBody(),
      bottomNavigationBar: customNavigatorBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    switch( currentIndex ) {

      case 0:
        return AsistenciaSreen();


      case 1:
        return ConfiguracionScreen();

      default:
        return ConfiguracionScreen();
    }

  }
}

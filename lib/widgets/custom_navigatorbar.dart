import 'package:asistencia_app/models/models.dart';
import 'package:asistencia_app/services/services.dart';
import 'package:asistencia_app/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asistencia_app/providers/ui_provider.dart';

class customNavigatorBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    // final List<String> rolesItems = Provider.of<ParcelsMemberService>(context, listen: false).rolesItems;

    final currentIndex = 0;

    return BottomNavigationBar(
      onTap: ( i ) {
        print(i);
        uiProvider.selectedMenuOpt = i;
      },
      currentIndex: currentIndex,
      elevation: 0,
      backgroundColor: Colors.white,
      fixedColor: Colors.lightBlue[800],
      unselectedItemColor: Colors.grey[600],
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.water_damage_outlined),
          label: 'Inicio',
          activeIcon: Icon(Icons.water_damage),
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.view_list_outlined),
        //   label: 'Lectura',
        //   activeIcon: Icon(Icons.view_list)
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.watch_later_outlined),
        //   label: 'Asistencia',
        //   activeIcon: Icon(Icons.watch_later)
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Cofiguracion',
          activeIcon: Icon(Icons.settings)
        ),
      ],
    );
  }
}


import 'dart:convert';

import 'package:asistencia_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _storage;

  // static Member _member = new Member();

  static User _user = new User();

  static List<Rol> _roles = [];

  static List<String> _rolesItems = [];

  static String _idDia = '';

  // static Setting _setting = new Setting();

  static Future init() async{
    _storage = await SharedPreferences.getInstance();
  }

  // static Member get member {
  //   return Member.fromMap( json.decode( _storage.getString('member')! ));
  // }

  // static set member(Member member){
  //   _member = member;
  //   _storage.setString('member', jsonEncode(member.toMap()));
  // }

  static User get user {
    return User.fromMap( json.decode( _storage.getString('user')! ));
  }

  static set user (User user) {
    _user = user;
    _storage.setString('user', jsonEncode(user.toMap()));
  }

  static List<Rol> get roles {
    List decodedResp = json.decode( _storage.getString('roles')! );
    print(decodedResp);
    List<Rol> rolesAux=[];
    for (var i = 0; i < decodedResp.length; i++) {
      rolesAux.add(Rol.fromMap( json.decode(decodedResp[i]) ));
    }
    return rolesAux;
  }

  static set roles(List<Rol> roles){
    _roles = roles;
    _storage.setString('roles', jsonEncode(roles));
  }

  static List<String> get rolesItems {
    // List<String> rolesItemsAux = json.decode( _storage.getString('roles_items')! ) ?? [];
    List decodedResp = json.decode( _storage.getString('roles_items')! );
    // print('roles_items');
    // print(decodedResp);
    List<String> rolesItemsAux = [];
    for (var i = 0; i < decodedResp.length; i++) {
      rolesItemsAux.add( decodedResp[i].toString() );
    }
    print(jsonEncode(rolesItemsAux));
    return rolesItemsAux;
  }

  static set rolesItems(List<String> rolesItems){
    _rolesItems = rolesItems;
    print(jsonEncode(rolesItems));
    _storage.setString('roles_items', jsonEncode(rolesItems));
  }

  // static Setting get setting {
  //   return Setting.fromMap( json.decode( _storage.getString('setting')! ));
  // }

  // static set setting(Setting setting){
  //   _setting = setting;
  //   _storage.setString('setting', jsonEncode(setting.toMap()));
  // }


  static String get idDia {
    return json.decode( _storage.getString('id_dia')! ).toString();
  }

  static set idDia(String idDia){
    _idDia = idDia;
    _storage.setString('id_dia', idDia);
  }
}

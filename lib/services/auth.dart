import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goplus/screens/user_signup_screen.dart';
import 'package:goplus/widget/notification_dialog.dart';
import 'package:goplus/widget/notification_loader.dart';
import '../main.dart';
import '../taxi/screens/verify_number_screen.dart';
import 'dio.dart';

class Auth extends ChangeNotifier{
  bool _isLoggedIn = false;
  var _user;
  String? _token;

  bool get authenticated => _isLoggedIn;
  get user => _user!;

  final storage = new FlutterSecureStorage();

  void login ({required Map creds, required BuildContext context}) async {
    notification_loader(context, (){});

    try {
      Dio.Response response = await dio()!.post('', data: creds);
      if(response.statusCode == 200){
        var res = jsonDecode(response.data);
        if(res['code'] == "OTP"){
          String token = res['token'].toString();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => VerifyNumberScreen(phone: creds['phone']))
          );
        } else if(res['NOK']){
          notification_dialog(
              context,
              'Vérifiez votre mot de passe',
              Icons.error,
              Colors.red,
              {'label': 'REESAYEZ', "onTap": (){
                Navigator.pop(context);
              }},
              20,
              false);
        } else if (res['KO']){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UserSignupScreen())
          );
        } else {
          notification_dialog(
              context,
              'Une erreur c\'est produite.',
              Icons.error,
              Colors.red,
              {'label': 'REESAYEZ', "onTap": (){
                Navigator.pop(context);
                Navigator.pop(context);
              }},
              20,
              false);
        }
      }
    } catch (e){
      notification_dialog(
          context,
          'Une erreur c\'est produite.',
          Icons.error,
          Colors.red,
          {'label': 'FERMER', "onTap": (){
            Navigator.pop(context);
            Navigator.pop(context);
          }},
          20,
          false);
    }
  }

  void register ({required Map cred, required BuildContext context}) async {

    try {
      Dio.Response response = await dio()!.post('', data: cred);
      if(response.statusCode == 200){
        var res = jsonDecode(response.data);
        if(res['code'] == 1){
          String token = res['token'].toString();
        } else {
          // showAlertDialog(context, 'Authentification', '${res['data'].toString()}');
        }
      }
    } catch (e){
      // showAlertDialog(context, 'Authentification', '${e.toString()}');
    }
  }

  void storeToken({required String token}) async{
    this.storage.write(key: 'token', value: token);
    notifyListeners();
  }

  Future<String?> getToken() async{
    return await storage.read(key: 'token');
  }

  void logout() async{
    try {
      Dio.Response response = await dio()!.get('/user/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'})
      );
      cleanUp();
      notifyListeners();
    } catch (e){

    }
  }

  void cleanUp() async {
    await storage.delete(key: 'token');
    notifyListeners();
  }
}
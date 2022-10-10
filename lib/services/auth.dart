import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goplus/screens/user_signup_screen.dart';
import 'package:goplus/widget/notification_dialog.dart';
import 'package:goplus/widget/notification_loader.dart';
import '../taxi/screens/verify_number_screen.dart';
import 'dio.dart';

class Auth extends ChangeNotifier{
  String? _token;

  final storage = new FlutterSecureStorage();

  void login ({required Map<String, dynamic> creds, required BuildContext context}) async {
    notification_loader(context, (){});

    try {
      Dio.Response response = await dio()!.post('/v1/', data: creds);
      var res = jsonDecode(response.data);
      if(response.statusCode == 200){
        if(res['code'] == "OTP"){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => VerifyNumberScreen(phone: creds['phone']))
          );
        } else if(res['code'] == 'NOK'){
          sendOtp(context, creds['phone']).then((value){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VerifyNumberScreen(phone: creds['phone']))
            );
          });
        } else if (res['code'] == 'KO'){
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

  void register ({required Map<String, dynamic> cred, required BuildContext context}) async {

    notification_loader(context, (){});

    try {
      Dio.Response response = await dio()!.post('/v1/', data: cred);
      var res = jsonDecode(response.data);
      if(res['code'] == "OTP"){
        sendOtp(context, cred['phone']).then((value){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => VerifyNumberScreen(phone: cred['phone']))
          );
        });
      } else if(res['code'] == "NOK"){
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
      } else if (res['code'] == "KO"){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => VerifyNumberScreen(phone: cred['phone']))
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
    } catch (e){
      Navigator.pop(context);
      notification_dialog(
          context,
          'Une erreur c\'est produite. $e',
          Icons.error,
          Colors.red,
          {'label': 'FERMER', "onTap": (){
            Navigator.pop(context);
          }},
          20,
          false);
    }
  }

  Future<String> sendOtp(BuildContext context, String phone) async {
    try{
      var data = {
        "key": "otp",
        "phone": phone
      };
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
      Map<String, dynamic> datas = jsonDecode(response.data);
      notifyListeners();
      return datas['code'];
    } catch(e){
      return "KO $e";
    }
  }

  Future<String> checkOtp(BuildContext context, var data) async {
    try{
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
      Map<String, dynamic> datas = jsonDecode(response.data);
      notifyListeners();
      Navigator.pop(context);
      if(datas['code'] == 'OK'){
        this.storage.write(key: 'sid', value: data['sid']);
        storeToken(token: data['phone']);
      }
      return datas['code'];
    } catch(e){
      return "KO";
    }
  }

  void storeToken({required String token}) async{
    this.storage.write(key: 'token', value: token);
    notifyListeners();
  }

  Future<String?> getToken() async{
    return await storage.read(key: 'token');
  }

  Future<String?> getSid() async{
    return await storage.read(key: 'sid');
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goplus/screens/user_signup_screen.dart';
import 'package:goplus/widget/notification_dialog.dart';
import 'package:goplus/widget/notification_loader.dart';
import '../taxi/screens/verify_number_screen.dart';
import 'dio.dart';

class Auth extends ChangeNotifier{

  final storage = new FlutterSecureStorage();

  Future<Map<String, dynamic>> login ({required Map<String, dynamic> creds, required BuildContext context}) async {
    try {
      Dio.Response response = await dio()!.post('/v1/', data: creds);
      Map<String, dynamic> res = jsonDecode(response.data);
      if(response.statusCode == 200){
        return res;
      } else {
        return {
          'code': "NULL"
        };
      }
    } catch (e){
      return {
        'code': "ERROR",
        'error': e
      };
    }
  }

  Future<Map<String, dynamic>> register ({required Map<String, dynamic> cred, required BuildContext context}) async {

    try {
      Dio.Response response = await dio()!.post('/v1/', data: cred);
      Map<String, dynamic> res = jsonDecode(response.data);
      if(response.statusCode == 200){
        return res;
      } else {
        return {
          'code': "NULL"
        };
      }
    } catch (e){
      return {
        'code': "ERROR",
        'error': e
      };
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
      return "KO";
    }
  }

  Future<String> checkOtp(BuildContext context, var data) async {
    try{
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
      Map<String, dynamic> datas = jsonDecode(response.data);
      notifyListeners();
      Navigator.pop(context);
      if(datas['code'] == 'OK'){
        this.storage.write(key: 'sid', value: datas['sid']);
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

  void cleanUp() async {
    await storage.delete(key: 'token');
    notifyListeners();
  }
}
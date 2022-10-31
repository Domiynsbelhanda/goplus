import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import '../utils/global_variable.dart';
import 'dio.dart';

class Auth extends ChangeNotifier{
  Future<Map<String, dynamic>> request ({required Map<String, dynamic> data}) async {
    try {
      Dio.Response response = await dio()!.post('/v1/', data: data);
      Map<String, dynamic> res = jsonDecode(response.data);
      if(response.statusCode == 200){
        return res;
      } else {
        return {
          'code': "NULL",
          'error': response.statusCode
        };
      }
    } catch (e){
      return {
        'code': "ERROR",
        'error': e
      };
    }
  }

  Future<Map<String, dynamic>> login ({required Map<String, dynamic> creds, required BuildContext context}) async {
    try {
      Dio.Response response = await dio()!.post('/v1/', data: creds);
      Map<String, dynamic> res = jsonDecode(response.data);
      if(response.statusCode == 200){
        return res;
      } else {
        return {
          'code': "NULL",
          'error': response.statusCode
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
        "key": "create_user",
        "action": "otp",
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

  Future<Map<String, dynamic>> checkOtp(BuildContext context, var data) async {
    try{
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
      Map<String, dynamic> datas = jsonDecode(response.data);
      notifyListeners();
      if(datas['code'] == 'OK'){
        storage.write(key: 'sid', value: datas['sid']);
        storeToken(token: data['phone']);
      }
      return datas;
    } catch(e){
      return {
        'code': "KO"
      };
    }
  }

  Future<Map<String, dynamic>> checkSID(BuildContext context, var data) async {
    try{
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
      Map<String, dynamic> datas = jsonDecode(response.data);
      notifyListeners();
      return datas;
    } catch(e){
      return {
        'code': "KO"
      };
    }
  }

  void storeToken({required String token}) async{
    storage.write(key: 'token', value: token);
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import '../utils/global_variable.dart';
import 'dio.dart';

class Auth extends ChangeNotifier{
  Future<Map<String, dynamic>> request ({required Map<String, dynamic> data}) async {
    try {
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
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
import 'package:dio/dio.dart';

Dio? dio(){
  Dio dio = new Dio();

  // dio.options.baseUrl = "http://10.0.2.2:8000/api";
  dio.options.baseUrl = "https://go-plus.info/api/rest";
  dio.options.responseType = ResponseType.plain;
  dio.options.contentType = 'application/json';
  dio.options.headers['accept'] = 'Application/Json';
  dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
  dio.options.headers['Charset'] = 'utf-8';

  return dio;
}
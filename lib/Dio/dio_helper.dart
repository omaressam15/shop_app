
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{

  static Dio dio;

  static inti(){

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true
      ),
    );
  }

 static Future<Response> getData({
   @required String url,
   String lang = 'en',
   String token,
   dynamic query})

   async{

    dio.options.headers = {

      'lang' : lang,
      'Authorization' :token,
      'Content-Type':'application/json'

    };

   return await dio.get(
       url,
       queryParameters: query,
   );

}

static Future<Response> postData({
  @required String url,
  @required Map<String,dynamic>data,
  String lang = 'en',
  String token,
  Map<String,dynamic>query,

}) async {

  dio.options.headers = {

    'Content-Type':'application/json',
    'lang':lang,
    'Authorization': token,
  };

    return await dio.post(
        url,
        queryParameters: query,
        data: data,
    );

}

  static Future<Response> updateData({
    @required String url,
    @required Map<String,dynamic>data,
    String lang = 'en',
    String token,
    Map<String,dynamic>query,

  }) async {

    dio.options.headers = {

      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };

    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );

  }

  static Future<Response> deleteData({
    @required String url,
    @required Map<String,dynamic>data,
    String lang = 'en',
    String token,
    Map<String,dynamic>query,

  }) async {

    dio.options.headers = {

      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token??'',
    };

    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );

  }


}
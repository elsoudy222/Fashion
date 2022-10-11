

import 'package:dio/dio.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          }
      ),
    );
  }

static  Future<Response> getData({
  required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    //String? token,
})async{
    dio!.options.headers={
      "lang" : lang,
      //"Authorization" : token??'',
      "Content-Type" : "application/json",
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String,dynamic> data,
    String lang = "en",
    String? token,
})async{
    dio!.options.headers={
      "lang" : lang,
    "Authorization" : token??'',
    "Content-Type" : "application/json",
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> puttData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String,dynamic> data,
    String lang = "en",
    String? token,
})async{
    dio!.options.headers={
      "lang" : lang,
    "Authorization" : token??'',
    "Content-Type" : "application/json",
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> deleteData ({
    required String url,
    String lang = 'en',
    String ?token
  })async
  {
    dio!.options.headers =
    {
      'lang' : lang,
      'Authorization' : token??'',
      'Content-Type' : 'application/json',
    };
    return await dio!.delete(url);
  }



}
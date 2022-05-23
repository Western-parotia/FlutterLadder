import 'package:dio/dio.dart';

class HttpClient {
  static late final Dio? _dio;

  // 私有的命名构造函数
  HttpClient._internal() {
    _dio = Dio();
  }

  static late final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  static Dio getDio() {
    return _instance._accessDio();
  }

  Dio _accessDio() {
    return _dio!;
  }
}

class ServiceApiConstants{
  static const String _domain = "https://www.wanandroid.com";


  static const String feeds = _domain + "/article/listproject/";
}

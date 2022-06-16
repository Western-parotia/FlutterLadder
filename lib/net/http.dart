import 'package:dio/dio.dart';

class DHttpClient {
  static late final Dio? _dio;

  // 私有的命名构造函数
  DHttpClient._internal() {
    _dio = Dio();
  }

  static late final DHttpClient _instance = DHttpClient._internal();

  factory DHttpClient() => _instance;

  static Dio getDio() {
    return _instance._accessDio();
  }

  Dio _accessDio() {
    return _dio!;
  }
}

class ApiPath {
  static const String _domain = "https://www.wanandroid.com";

  static String combinationUrl(String path) {
    return _domain + path;
  }

  static String bannerJson = combinationUrl("/banner/json");

  static String topJson = combinationUrl("/article/top/json");

  static String login = combinationUrl("/user/login");
}

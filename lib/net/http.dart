import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wanandroid_app/net/root_model.dart';

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

class DataRepository {
  static final _dio = HttpClient.getDio();

  static Future<BasicRootModel<UserInfo>> login(
      String userName, String password) async {
    final res = await _dio.post(ApiPath.login, queryParameters: {
      'username': userName,
      'password': password,
    });

    final rootModel =
        BasicRootModel.fromJsonT(res.data, (t) => UserInfo.formJson(t));
    return rootModel;
  }
}

extension FutureExt<T> on Future<BasicRootModel<T>> {
  void httpThen(Function(T m) onSuccess,
      {Function(String code, String msg)? onError}) {
    then((value) => {});
  }
}

void main() {
  DataRepository.login('juzixs', "123456")
      .httpThen((value) {}, onError: (code, msg) {});

  DataRepository.login('juzixs', "123456").then((value) {
    print(value.errorCode);
    print(value.errorMsg);
    UserInfo? info = value.data;
  }, onError: (xx) {});
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

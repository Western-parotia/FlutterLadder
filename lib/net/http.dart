import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wanandroid_app/net/NetRepository.dart';
import 'package:wanandroid_app/net/root_model.dart';

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

extension FutureExt<T> on Future<BasicRootModel<T>> {
  void httpThen(Function(T m) onSuccess,
      {Function(String code, String msg)? resError}) {
    then((value) => {
          if (value.errorCode != 0)
            {
              if (null != resError) {resError("1", "")}
            }
          else
            {print(value.data!.runtimeType)}
        });
  }
}

void main() {
  NetRepository.login('juzixs', "123456")
      .httpThen((value) {}, onError: (code, msg) {});

  NetRepository.login('juzixs', "123456").then((value) {
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

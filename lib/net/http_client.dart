import 'package:dio/dio.dart';
import 'package:wanandroid_app/net/root_model.dart';

import 'http_api.dart';

class NetClient {
  static late final Dio? _dio;

  // 私有的命名构造函数
  NetClient._internal() {
    _dio = Dio();
  }

  static late final NetClient _instance = NetClient._internal();

  factory NetClient() => _instance;

  static Dio getDio() {
    return _instance._accessDio();
  }

  Dio _accessDio() {
    return _dio!;
  }

  static Future postForm(String path, Map<String, dynamic> query) async {
    try {
      return await getDio().post(path,
          queryParameters: query,
          options: Options(contentType: "application/x-www-form-urlencode"));
    } catch (e, s) {
      return BasicRootModel(
          errorCode: NetCode.NET_ERROR_REQUEST, errorMsg: "$e,$s");
    }
  }

  static Future get(String path, Map<String, dynamic> query) async {
    try {
      return await getDio().get(path, queryParameters: query);
    } catch (e, s) {
      return BasicRootModel(
          errorCode: NetCode.NET_ERROR_REQUEST, errorMsg: "$e,$s");
    }
  }

  static Future postJson(String path, Map<String, dynamic> query) async {
    try {
      return await getDio().post(path,
          queryParameters: query,
          options: Options(contentType: "application/json"));
    } catch (e, s) {
      return BasicRootModel(
          errorCode: NetCode.NET_ERROR_REQUEST, errorMsg: "$e,$s");
    }
  }
}

extension _ListExt on List {
  List<T> formListJson<T>(T Function(dynamic) format) {
    List<T> l = [];
    for (var e in this) {
      l.add(format(e));
    }
    return l;
  }
}

/// 定义解析
extension FutureExt on Future {
  /// dynamic data = res.data
  void thenObj<T>(T Function(dynamic data) format,
      {required Function(T t) onSuccess,
      Function(int code, String msg)? onError}) {
    then((value) {
      try {
        if (value is BasicRootModel) {
          onError?.call(value.errorCode, value.errorMsg);
          return null;
        } else {
          var r = BasicRootModel.fromJson(value.data);
          if (r.errorCode != NetCode.NET_SUCCESS) {
            onError?.call(r.errorCode, r.errorMsg);
          } else {
            //还没取出data，这里是 res
            var rt = BasicRootModelT.fromJsonT(value.data, (p0) => format(p0));
            if (rt.data == null) {
              onError?.call(NetCode.NET_ERROR_DATA_NULl, "data null");
              return 0;
            } else {
              onSuccess(rt.data!);
            }
          }
        }
      } catch (e, s) {
        onError?.call(NetCode.NET_ERROR_PARSE, "$e,$s");
      }
    });
  }

  void thenList<T>(T Function(dynamic map) format,
      {required Function(List<T> t) onSuccess,
      Function(int code, String msg)? onError}) {
    thenObj<List<T>>((v) {
      var d = v as List;
      return d.formListJson((p0) => format(v));
    }, onSuccess: onSuccess);
  }

  void thenPageList<T>(T Function(dynamic map) format,
      {required Function(List<T> t) onSuccess,
      Function(int code, String msg)? onError}) {}
}

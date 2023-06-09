import 'package:dio/dio.dart';
import 'package:wanandroid_app/net/root_model.dart';

import 'http_api.dart';
import 'net_repository.dart';

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

  static Future<Result<T>> get<T>(String path,
      {Map<String, dynamic>? query}) async {
    try {
      var res = await getDio().get(path, queryParameters: query);
      print("$path==>$res");
      return Result.success(res.data);
    } catch (e, s) {
      return Result.fail("$path,$e,$s");
    }
  }

  static Future<Result<T>> postForm<T>(String path,
      {Map<String, dynamic>? query}) async {
    try {
      var res = await getDio().post(path,
          queryParameters: query,
          options: Options(contentType: "application/x-www-form-urlencode"));
      print("$path==>$res");
      return Result.success(res.data);
    } catch (e, s) {
      return Result.fail("$path,$e,$s");
    }
  }

  static Future<Result<T>> postJson<T>(String path,
      {Map<String, dynamic>? query}) async {
    try {
      var res = await getDio().post(path,
          queryParameters: query,
          options: Options(contentType: "application/json"));
      print("$path==>$res");
      return Result.success(res.data);
    } catch (e, s) {
      return Result.fail("$path,$e,$s");
    }
  }
}

///用户在网络请求 Future中可以保存泛型类型，作为数据解析类型的类型限制
///提供 tcp层的网络访问状况
class Result<T> {
  final dynamic res;
  final int code;
  final String? errorDetail;

  Result({this.res, required this.code, this.errorDetail});

  Result.success(dynamic response)
      : res = response,
        code = NetCode.NET_REQUEST_SUCCESS,
        errorDetail = null;

  Result.fail(String detail)
      : res = null,
        code = NetCode.NET_ERROR_REQUEST,
        errorDetail = detail;

  static String getUserMsg(int code) {
    String userMsg = "网络错误:$code";
    switch (code) {
      case NetCode.NET_ERROR_REQUEST:
        break;
      default:
        break;
    }
    return userMsg;
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

/// 只能用于单层集合 {"data":[]}
extension FutureExtList<T> on Future<Result<List<T>>> {
  /// format 是用于解析[x,x]的x
  void thenList(T Function(dynamic obj) format,
      {required Function(List<T> t) onSuccess,
      Function(int code, String msg)? onError}) {
    thenObj((v) {
      /// 这里的v 是 {"data":[]} 中的[]
      var d = v as List;
      return d.formListJson((p0) => format(p0));
    }, onSuccess: onSuccess, onError: onError);
  }

  DataBox<List<T>> thenListDataBox(T Function(dynamic data) format) {
    DataBox<List<T>> box = DataBox();
    thenList((data) => format(data),
        onSuccess: (v) => box.sendSuccess(v),
        onError: (e, s) => box.sendError(e, s));
    return box;
  }

  /// 用户获取指定集合对象 {"data":{"aList":[],"bList":[]}}
  void thenListSpecial(
      dynamic Function(dynamic data) find, T Function(dynamic obj) format,
      {required Function(List<T> t) onSuccess,
      Function(int code, String msg)? onError}) {
    thenObj((v) {
      /// 这里的v 是 {"data":x} 中的x
      var special = find(v);
      var d = special as List;
      return d.formListJson((p0) => format(p0));
    }, onSuccess: onSuccess, onError: onError);
  }

  DataBox<List<T>> thenListSpecialDataBox(
    dynamic Function(dynamic data) find,
    T Function(dynamic obj) format,
  ) {
    DataBox<List<T>> box = DataBox();
    thenListSpecial((data) => find(data), (obj) => format(obj),
        onSuccess: (v) => box.sendSuccess(v),
        onError: (e, s) => box.sendError(e, s));
    return box;
  }
}

extension FutureExt<T> on Future<Result<T>> {
  /// 这里的data 是 {"data":dynamic} 中的 dynamic
  void thenObj(T Function(dynamic data) format,
      {required Function(T t) onSuccess,
      Function(int code, String msg)? onError}) {
    then((value) {
      try {
        print("${value.code}=>${value.res}=>${value.errorDetail}");
        if (value.code != NetCode.NET_REQUEST_SUCCESS) {
          onError?.call(value.code, Result.getUserMsg(value.code));
        } else {
          var r = BasicRootModel.fromJson(value.res);
          if (r.errorCode != NetCode.RES_DATA_SUCCESS) {
            onError?.call(r.errorCode, r.errorMsg);
          } else {
            //还没取出data，这里是 res
            var rt = BasicRootModelT.fromJsonT(value.res, (p0) => format(p0));
            if (rt.data == null) {
              onError?.call(NetCode.RES_ERROR_DATA_NULL,
                  Result.getUserMsg(NetCode.RES_ERROR_DATA_NULL));
            } else {
              onSuccess(rt.data!);
            }
          }
        }
      } catch (e, s) {
        print("$e,$s");
        onError?.call(NetCode.RES_ERROR_PARSE,
            Result.getUserMsg(NetCode.RES_ERROR_PARSE));
      }
    });
  }

  DataBox<T> thenObjDataBox(T Function(dynamic data) format) {
    DataBox<T> box = DataBox();
    thenObj((data) => format(data),
        onSuccess: (v) => box.sendSuccess(v),
        onError: (e, s) => box.sendError(e, s));
    return box;
  }
}

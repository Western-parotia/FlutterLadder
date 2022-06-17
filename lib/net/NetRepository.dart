import 'package:wanandroid_app/net/http.dart';
import 'package:wanandroid_app/net/root_model.dart';

class BasicRepository {
  static final _dio = DHttpClient.getDio();

  static Future post(String path, Map<String, dynamic> query) async {
    try {
      return await _dio.post(path, queryParameters: query);
    } catch (e, s) {
      return BasicRootModel(errorCode: NetCode.NET_ERROR, errorMsg: "$e,$s");
    }
  }
}

extension ListExt on List {
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

void main() {
  BasicRepository.post(ApiPath.login, {
    'username': "juzixs",
    'password': "123456",
  }).thenObj<UserInfo>((map) => UserInfo.formJson(map), onSuccess: (value) {
    print("==1${value.username}");
  }, onError: (e, s) {});

  //
  // BasicRepository.post(ApiPath.login, {
  //   'username': "juzixs",
  //   'password': "123456",
  // }).login(
  //     onSuccess: (t) {
  //       print(t.username);
  //     },
  //     onError: (e, s) {});
}

/// 定义接口
class WanAndroidApi {
  static Future login(String userName, String password) async {
    var res = await BasicRepository.post(ApiPath.login, {
      'username': userName,
      'password': password,
    });
    return res;
  }
}

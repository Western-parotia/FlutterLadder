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

bool _checkResSuccess(
    BasicRootModel root, Function(int code, String msg)? onError) {
  if (root.errorCode != NetCode.NET_SUCCESS) {
    onError?.call(root.errorCode, root.errorMsg);
    return false;
  }
  if (root.data == null) {
    onError?.call(NetCode.NET_ERROR_DATA_NULl, "data null");
    return false;
  }

  return true;
}

extension ListParseExt<T> on dynamic {
  List<T> formJson(T Function(dynamic) format) {
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
          return;
        }

        //还没取出data，这里是 res
        var root = BasicRootModel.fromJsonT(value.data, (p0) => format(p0));
        if (_checkResSuccess(root, onError)) {
          onSuccess(root.data!);
        }
      } catch (e, s) {
        onError?.call(NetCode.NET_ERROR_PARSE, "$e,$s");
      }
    });
  }

  void thenList<T>(T Function(dynamic map) format, //单匀速解析器
      {required Function(List<T> t) onSuccess,
      Function(int code, String msg)? onError}) {
    thenObj<List<T>>((v) {
      return v.formJson((p0) => format(v));
    }, onSuccess: onSuccess);
  }

  void thenPageList<T>(T Function(dynamic map) format, //单匀速解析器
      {required Function(List<T> t) onSuccess,
      Function(int code, String msg)? onError}) {}
}

void main() {
  BasicRepository.post(ApiPath.login, {
    'username': "juzixs",
    'password': "123456",
  }).thenObj<List<UserInfo>>(
    (data) => data.formJson((p0) => UserInfo.formJson(p0)),
    onSuccess: (value) {
      print("==1${value..length}");
    },
  );

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

import 'package:wanandroid_app/net/http_api.dart';
import 'package:wanandroid_app/net/http_client.dart';
import 'package:wanandroid_app/net/root_model.dart';

void main() {
  WanAndroidRepository.login("juzixs", "123456")
      .thenObj<UserInfo>((data) => UserInfo.formJson(data), onSuccess: (v) {
    print("==1${v.username}");
  }, onError: (e, s) {
    print("==1$e $s");
  });
}

/// 定义接口
class WanAndroidRepository {
  static Future login(String userName, String password) async {
    var res = await NetClient.postForm(WanAndroidApi.login, {
      'username': userName,
      'password': password,
    });
    return res;
  }
}

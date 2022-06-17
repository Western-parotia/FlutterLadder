import 'package:wanandroid_app/net/http_api.dart';
import 'package:wanandroid_app/net/http_client.dart';

import '../modules/home/model/banner_model.dart';

void main() {
  WanAndroidRepository.getBanner().thenList<BannerModel>(
      (map) => BannerModel.fromJsonMapToModel(map), onSuccess: (list) {
    print("==1$list");
  }, onError: (e, s) {
    print("==1$e $s");
  });

  // WanAndroidRepository.login("juzixs", "123456")
  //     .thenObj<UserInfo>((data) => UserInfo.formJson(data), onSuccess: (v) {
  //   print("==1${v.username}");
  // }, onError: (e, s) {
  //   print("==1$e $s");
  // });
}

/// 定义接口
class WanAndroidRepository {
  static Future login(String userName, String password) async {
    return await NetClient.postForm(WanAndroidApi.login, query: {
      'username': userName,
      'password': password,
    });
  }

  static Future getBanner() async {
    return await NetClient.get(WanAndroidApi.bannerJson);
  }
}

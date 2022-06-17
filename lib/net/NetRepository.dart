import 'package:wanandroid_app/net/http_api.dart';
import 'package:wanandroid_app/net/http_client.dart';

import '../modules/home/model/article_model.dart';
import '../modules/home/model/banner_model.dart';
import '../modules/mine/mode/userinfo_model.dart';

void main() {
  // WanAndroidRepository.getBanner().thenList(
  //     (map) => BannerModel.fromJsonMapToModel(map), onSuccess: (list) {
  //   print("==${list.length}");
  // }, onError: (e, s) {
  //   print("==$e $s");
  // });

  // WanAndroidRepository.login("juzixs", "123456")
  //     .thenObj((data) => UserinfoModel.fromJson(data), onSuccess: (v) {
  //   print("==1${v.username}");
  // }, onError: (e, s) {
  //   print("==1$e $s");

  WanAndroidRepository.getArticles(1).thenListSpecial(
      (data) => data["datas"], (obj) => ArticleModel().fromJsonMapToModel(obj),
      onSuccess: (v) {
    print("onSuccess=== $v");
  });

  // });
}

/// 1.定义接口与返回值类型
class WanAndroidRepository {
  static Future<Result<UserinfoModel>> login(
      String userName, String password) async {
    return await NetClient.postForm(WanAndroidApi.login, query: {
      'username': userName,
      'password': password,
    });
  }

  static Future<Result<List<BannerModel>>> getBanner() async {
    return await NetClient.get<List<BannerModel>>(WanAndroidApi.bannerJson);
  }

  static Future<Result<List<ArticleModel>>> getTops() async {
    return await NetClient.get<List<ArticleModel>>(WanAndroidApi.topJson);
  }

  static Future<Result<List<ArticleModel>>> getArticles(int page) async {
    return await NetClient.get<List<ArticleModel>>(
        WanAndroidApi.articleList(page));
  }
}

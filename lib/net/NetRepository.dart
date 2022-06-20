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

  WanAndroidRepository.login("juzixs", "123456")
      .offerSuccess((p0) => print("==1${p0.username}"))
      .offerError((code, msg) => print("==1$code $msg"));
}

class DataBox<E> {
  List<Function(E)>? _successOffers;

  List<Function(int code, String msg)>? _errorOffers;

  void sendSuccess(E e) {
    _successOffers?.forEach((element) {
      element.call(e);
    });
  }

  void sendError(int code, String msg) {
    _errorOffers?.forEach((element) {
      element.call(code, msg);
    });
  }

  DataBox<E> offerSuccess(Function(E) f) {
    _successOffers ??= [];
    _successOffers!.add(f);
    return this;
  }

  DataBox<E> offerError(Function(int code, String msg) f) {
    _errorOffers ??= [];
    _errorOffers!.add(f);
    return this;
  }
}

/// 1.定义接口与返回值类型
class WanAndroidRepository {
  // Future<Result<UserinfoModel>>
  static DataBox<UserinfoModel> login(String userName, String password) {
    var result = NetClient.postForm<UserinfoModel>(WanAndroidApi.login, query: {
      'username': userName,
      'password': password,
    });
    return result.thenObjDataBox((data) => UserinfoModel.fromJson(data));
  }

  static DataBox<List<BannerModel>> getBanner() {
    return NetClient.get<List<BannerModel>>(WanAndroidApi.bannerJson)
        .thenListDataBox((data) => BannerModel.fromJsonMapToModel(data));
  }

  static DataBox<List<ArticleModel>> getTops() {
    return NetClient.get<List<ArticleModel>>(WanAndroidApi.topJson)
        .thenListDataBox((data) => ArticleModel().fromJsonMapToModel(data));
  }

  static DataBox<List<ArticleModel>> getArticles(int page) {
    return NetClient.get<List<ArticleModel>>(WanAndroidApi.articleList(page))
        .thenListSpecialDataBox((data) => data["datas"],
            (obj) => ArticleModel().fromJsonMapToModel(obj));
  }
}

import 'package:dio/dio.dart';
import 'package:wanandroid_app/net/http.dart';
import 'package:wanandroid_app/net/root_model.dart';

class NetRepository {
  static final _dio = DHttpClient.getDio();

  static Future<BasicRootModel<UserInfo>> login(
      String userName, String password) async {
    late BasicRootModel<UserInfo> rootModel;
    Response<dynamic> res;
    try {
      res = await _dio.post(ApiPath.login, queryParameters: {
        'username': userName,
        'password': password,
      });
    } catch (e, s) {
      return BasicRootModel(errorCode: NetCode.NET_ERROR, errorMsg: "$e,$s");
    }

    try {
      rootModel =
          BasicRootModel.fromJsonT(res.data, (t) => UserInfo.formJson(t));
    } catch (e, s) {
      return BasicRootModel(
          errorCode: NetCode.NET_ERROR_PARSE, errorMsg: "$e,$s");
    }
    return rootModel;
  }
}

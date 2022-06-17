class NetCode {
  static const RES_DATA_SUCCESS = 0;

  static const NET_REQUEST_SUCCESS = -9000;

  static const NET_ERROR_REQUEST = -8000; //网络访问错误
  static const RES_ERROR_PARSE = -8001;
  static const RES_ERROR_DATA_NULL = -8002;
}

class WanAndroidApi {
  static const String _domain = "https://www.wanandroid.com";

  static String combinationUrl(String path) {
    return _domain + path;
  }

  static String bannerJson = combinationUrl("/banner/json");

  static String topJson = combinationUrl("/article/top/json");

  static String login = combinationUrl("/user/login");

  static String articleList(int page) =>
      combinationUrl("/article/list/$page/json");
}

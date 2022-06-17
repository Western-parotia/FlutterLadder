class NetCode {
  static const RES_DATA_SUCCESS = 0;

  static const NET_REQUEST_SUCCESS = -9000;

  static const NET_ERROR_REQUEST = -8000; //网络访问错误
  static const RES_ERROR_PARSE = -8001;
  static const RES_ERROR_DATA_NULL = -8002;
}

class WanAndroidApi {
  static const String _domain = "https://www.wanandroid.com";

  static String _combinationUrl(String path) {
    return _domain + path;
  }

  static String bannerJson = _combinationUrl("/banner/json");

  static String topJson = _combinationUrl("/article/top/json");

  static String login = _combinationUrl("/user/login");

  static String articleList(int page) =>
      _combinationUrl("/article/list/$page/json");
}

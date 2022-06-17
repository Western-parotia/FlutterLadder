class NetCode {
  static const NET_SUCCESS = 0;

  static const NET_ERROR_REQUEST = -9200; //网络访问错误
  static const NET_ERROR_PARSE = -9201;
  static const NET_ERROR_DATA_NULl = -9202;
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

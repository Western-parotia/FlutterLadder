// ignore_for_file: constant_identifier_names

import 'dart:convert';

/// data : ""
/// errorCode : 0
/// errorMsg : ""

class NetCode {
  static const int DEFAULT = -9000;
  static const int NET_ERROR = -9001;
  static const int NET_ERROR_PARSE = -9002;
  static const int NET_NO_CODE = -9003;
}

const _DATA_KEY = 'data';

class WanAndroidRootRes {
  final int errorCode;
  final String errorMsg;

  WanAndroidRootRes.parse(Map map)
      : errorCode = map['errorCode'] ?? NetCode.NET_NO_CODE,
        errorMsg = map['errorMsg'] ?? "no-msg";
}

class WanAndroidRootDynamicRes extends WanAndroidRootRes {
  final dynamic data;

  WanAndroidRootDynamicRes.parse(Map<String, dynamic> map)
      : data = map[_DATA_KEY],
        super.parse(map);
}

class WanAndroidRootObjRes<T> extends WanAndroidRootRes {
  final T data;

  WanAndroidRootObjRes.parse(
      Map<String, dynamic> map, T Function(dynamic) format)
      : data = _p(map, format),
        super.parse(map);

  static T _p<T>(Map<String, dynamic> map, T Function(dynamic) format) {
    return format(map[_DATA_KEY]);
  }
}

class WanAndroidRootListRes<T> extends WanAndroidRootRes {
  final List<T> data;

  WanAndroidRootListRes.parse(
      Map<String, dynamic> map, T Function(dynamic) format)
      : data = _p(map, format),
        super.parse(map);

  static List<T> _p<T>(Map<String, dynamic> map, T Function(dynamic) format) {
    List<T> l = [];
    List d = map[_DATA_KEY];
    for (final e in d) {
      l.add(format(e));
    }
    return l;
  }
}

void main() {
  var userRes = WanAndroidRootObjRes.parse(
      jsonDecode(basicJsonObj), (p0) => UserInfo.formJson(p0));
  print(userRes.data);

  var animalsRes = WanAndroidRootListRes.parse(
      jsonDecode(basicJsonList), (p0) => Animals.formJson(p0));
  print(animalsRes.data);
}

class UserInfo {
  String? username;

  UserInfo({this.username});

  UserInfo.formJson(dynamic json) {
    username = json['username'];
  }
}

class Animals {
  String? name;

  Animals({this.name});

  Animals.formJson(dynamic str) {
    name = str;
  }
}

const basicJsonObj = '''{
      "data": {"username":"juzixs"},
  "errorCode": 99900,
  "errorMsg": "111"
}''';
const basicJsonList = '''{
  "data":["dog","cat","ostrich"],
  "errorCode": 99900,
  "errorMsg": "111"
}''';

const basicJsonString = '''{
  "data":"wangXX",
  "errorCode": 99900,
  "errorMsg": "111"
}''';

const basicJsonInt = '''{
  "data":100,
  "errorCode": 99900,
  "errorMsg": "111"
}''';

import '../utils/log_utils.dart';

/// data : ""
/// errorCode : 0
/// errorMsg : ""

class NetCode {
  static const NET_DEFAULT = -9000;
  static const NET_SUCCESS = 0;

  static const NET_ERROR = -9200;
  static const NET_ERROR_PARSE = -9201;
  static const NET_ERROR_DATA_NULl = -9202;
}

class BasicRootModel<T> {
  T? data;
  int errorCode;
  String errorMsg;

  BasicRootModel({required this.errorCode, required this.errorMsg});

  BasicRootModel.fromJsonT(dynamic jd, T? Function(dynamic) format)
      : data = format(jd['data']),
        errorCode = jd['errorCode'] ?? -1,
        errorMsg = jd['errorMsg'] ?? "empty";

  BasicRootModel.fromJsonBasic(dynamic jd)
      : data = jd['data'],
        errorCode = jd['errorCode'] ?? -1,
        errorMsg = jd['errorMsg'] ?? "empty";

  static BasicRootModel<List<OBJ>> formJsonList<OBJ>(
      dynamic json, OBJ Function(dynamic) format) {
    return BasicRootModel.fromJsonT(json, (elements) {
      List<OBJ> list = [];
      for (final e in elements) {
        list.add(format(e));
      }
      return list;
    });
  }
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
  "list":["dog","cat","ostrich"],
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

void main() {
  var userRes = BasicRootModel<UserInfo>.fromJsonT(
      basicJsonObj, (x) => UserInfo.formJson(x));

  // Log.i("userRes:${userRes.errorCode ?? "====null===="}");
  // Log.i("userRes:${userRes.data?.username ?? "====null===="}");
  // Log.i("userRes:${userRes.errorMsg ?? "====null===="}");

  var animalsRes =
      BasicRootModel.formJsonList(basicJsonList, (p0) => Animals.formJson(p0));
  Log.i("animalsRes:${animalsRes?.data?.length ?? "====null===="}");

  var name = BasicRootModel<String>.fromJsonBasic(basicJsonString);
  var age = BasicRootModel<int>.fromJsonBasic(basicJsonInt);

  Log.i("name:${name.data} ,age:${age.data}====null====");
}

/// data : ""
/// errorCode : 0
/// errorMsg : ""



class BasicRootModel {
  int errorCode;
  String errorMsg;

  BasicRootModel({required this.errorCode, required this.errorMsg});

  BasicRootModel.fromJson(dynamic jd)
      : errorCode = jd['errorCode'] ?? -1,
        errorMsg = jd['errorMsg'] ?? "empty";
}

class BasicRootModelT<T> extends BasicRootModel {
  T? data;

  BasicRootModelT(int c, String m) : super(errorCode: c, errorMsg: m);

  BasicRootModelT.fromJsonT(dynamic jd, T? Function(dynamic) format)
      : data = format(jd['data']),
        super.fromJson(jd);

  BasicRootModelT.fromJsonBasic(dynamic jd)
      : data = jd['data'],
        super.fromJson(jd);

  static BasicRootModelT<List<OBJ>> formJsonList<OBJ>(
      dynamic json, OBJ Function(dynamic) format) {
    return BasicRootModelT.fromJsonT(json, (elements) {
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

  UserInfo.formJson(Map json) {
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


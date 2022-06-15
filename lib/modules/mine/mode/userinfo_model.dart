/// admin : false
/// coinCount : 46
/// email : ""
/// icon : ""
/// id : 132349
/// nickname : "juzixs"
/// password : ""
/// publicName : "juzixs"
/// token : ""
/// type : 0
/// username : "juzixs"

class UserinfoModel {
  UserinfoModel({
    this.admin,
    this.coinCount,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  UserinfoModel.fromJson(dynamic json) {
    admin = json['admin'];
    coinCount = json['coinCount'];
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }
  bool? admin;
  int? coinCount;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  UserinfoModel copyWith({
    bool? admin,
    int? coinCount,
    String? email,
    String? icon,
    int? id,
    String? nickname,
    String? password,
    String? publicName,
    String? token,
    int? type,
    String? username,
  }) =>
      UserinfoModel(
        admin: admin ?? this.admin,
        coinCount: coinCount ?? this.coinCount,
        email: email ?? this.email,
        icon: icon ?? this.icon,
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        password: password ?? this.password,
        publicName: publicName ?? this.publicName,
        token: token ?? this.token,
        type: type ?? this.type,
        username: username ?? this.username,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['admin'] = admin;
    map['coinCount'] = coinCount;
    map['email'] = email;
    map['icon'] = icon;
    map['id'] = id;
    map['nickname'] = nickname;
    map['password'] = password;
    map['publicName'] = publicName;
    map['token'] = token;
    map['type'] = type;
    map['username'] = username;
    return map;
  }

}
class BaseEntity {
  final int errorCode;
  final String errorMsg;
  final Map<String, dynamic> data;

  const BaseEntity(
      {required this.errorMsg, required this.errorCode, required this.data});

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    return BaseEntity(
      errorCode: json['errorCode'] as int,
      errorMsg: json['errorMsg'] as String,
      data: json['data'] as Map<String, dynamic>,
    );
  }
}

class PageData {
  final int curPage;
  final int total;
  final List<dynamic> datas;

  const PageData({
    required this.curPage,
    required this.total,
    required this.datas,
  });

  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      curPage: json['curPage'] as int,
      total: json['total'] as int,
      datas: json['datas'] as List<dynamic>,
    );
  }
}

class FeedItem {
  final String title;
  final int id;
  final String desc;
  final String author;
  final String envelopePic;
  final String niceDate;
  final num publishTime;

  const FeedItem(
  this.title,{this.desc="",this.author="",this.envelopePic="",this.niceDate="",this.id=-1,this.publishTime=-1}
  );

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      json['title'] as String,
      id: json['id'] as int,
      desc: json['desc'] as String,
      author: json['author'] as String,
      envelopePic: json['envelopePic'] as String,
      niceDate: json['niceDate'] as String,
      publishTime: json['publishTime'] as num,
    );
  }

  static List<FeedItem> fromJsonList(List<Map<String, dynamic>> json) {
    List<FeedItem> datas = List.generate(json.length, (index) {
      return FeedItem.fromJson(json[index]);
    });
    return datas;
  }
}

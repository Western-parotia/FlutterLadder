
// 引入
import 'package:json_annotation/json_annotation.dart';
// json_annotation 使用方法：https://www.jianshu.com/p/d89e5c642660

// 2.指定此类的代码生成文件(格式：part '类名.g.dart';)
part 'home_model.g.dart';

// 3.添加序列化标注
@JsonSerializable()
class HomeModel {
  String? author;  //作者
  int chapterId;
  String chapterName;
  String desc;
  bool collect;
  int courseId;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  int publishTime;
  int realSuperChapterId;
  int shareDate;
  String? shareUser;   //分享人
  int superChapterId;
  String superChapterName;
  String title;
  int type;
  int userId;
  int visible;
  int zan;
  List<Tag> tags;
  // 构造
  HomeModel({
    required this.desc,
    required this.author,
    required this.chapterId,
    required this.chapterName,
    required this.collect,
    required this.courseId,
    required this.id,
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.shareDate,
    required this.shareUser,
    required this.superChapterId,
    required this.superChapterName,
    required this.title,
    required this.type,
    required this.userId,
    required this.visible,
    required this.zan,
    required this.tags,
  });

  // 4.添加反序列化方法(格式：factory 类名.fromJson(Map<String, dynamic> json) => _$类名FromJson(json);)
  factory HomeModel.fromJson(dynamic json) {
    return _$HomeModelFromJson(json);
  }

 // 5.添加序列化方法(格式：Map<String, dynamic> toJson() => _$类名ToJson(this);)
  Map<String,dynamic> toJson() => _$HomeModelToJson(this);


}

// Tag类
@JsonSerializable()
class Tag {
  String name;
  String url;

  Tag({required this.name, required this.url});

  factory Tag.fromJson(dynamic json) {
    return _$TagFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TagToJson(this);
  }
}
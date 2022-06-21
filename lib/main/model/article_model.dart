class ArticleModel {
  String? apkLink;
  String? author;
  String? shareUser;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? envelopePic;
  bool? fresh;
  int? id;
  String? link;
  String? niceDate;
  String? origin;
  int? originId;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? superChapterId;
  String? superChapterName;
  List<TagsBean>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  ArticleModel.fromJsonMapToModel(Map map) {
    if (map.isEmpty) return;
    apkLink = map['apkLink'];
    author = map['author'];
    shareUser = map['shareUser'];
    chapterId = map['chapterId'];
    chapterName = map["chapterName"];
    collect = map['collect'];
    courseId = map['courseId'];
    desc = map["desc"];
    envelopePic = map['envelopePic'];
    fresh = map['fresh'];
    id = map['id'];
    link = map['link'];
    niceDate = map['niceDate'];
    origin = map['origin'];
    originId = map['originId'];
    prefix = map['prefix'];
    projectLink = map['projectLink'];
    publishTime = map['publishTime'];
    superChapterId = map['superChapterId'];
    superChapterName = map["superChapterName"];
    tags = List<TagsBean>.from((map['tags'] as List).map((item) => TagsBean.fromJsonMap(item)));
    title = map["title"];
    type = map['type'];
    userId = map['userId'];
    visible = map['visible'];
    zan = map['zan'];
  }
}

class TagsBean {
  String? name;
  String? url;

  static TagsBean fromJsonMap(Map<String, dynamic> map) {
    if (map.isEmpty) return TagsBean();
    TagsBean tagsBean = TagsBean();
    tagsBean.name = map['name'];
    tagsBean.url = map['url'];
    return tagsBean;
  }

  Map toJson() => {
        "name": name,
        "url": url,
      };
}

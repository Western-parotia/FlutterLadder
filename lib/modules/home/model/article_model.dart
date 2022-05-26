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

  ArticleModel fromJsonMapToModel(Map<String, dynamic> map) {
    if (map.isEmpty) return ArticleModel();
    ArticleModel articleBean = ArticleModel();
    articleBean.apkLink = map['apkLink'];
    articleBean.author = map['author'];
    articleBean.shareUser = map['shareUser'];
    articleBean.chapterId = map['chapterId'];
    articleBean.chapterName = map["chapterName"];
    articleBean.collect = map['collect'];
    articleBean.courseId = map['courseId'];
    articleBean.desc = map["desc"];
    articleBean.envelopePic = map['envelopePic'];
    articleBean.fresh = map['fresh'];
    articleBean.id = map['id'];
    articleBean.link = map['link'];
    articleBean.niceDate = map['niceDate'];
    articleBean.origin = map['origin'];
    articleBean.originId = map['originId'];
    articleBean.prefix = map['prefix'];
    articleBean.projectLink = map['projectLink'];
    articleBean.publishTime = map['publishTime'];
    articleBean.superChapterId = map['superChapterId'];
    articleBean.superChapterName = map["superChapterName"];
    articleBean.tags = List<TagsBean>.from(
        (map['tags'] as List).map((item) => TagsBean.fromJsonMap(item)));
    articleBean.title = map["title"];
    articleBean.type = map['type'];
    articleBean.userId = map['userId'];
    articleBean.visible = map['visible'];
    articleBean.zan = map['zan'];
    return articleBean;
  }

  Map fromJsonToMap() => {
        "apkLink": apkLink,
        "author": author,
        "shareUser": shareUser,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "collect": collect,
        "courseId": courseId,
        "desc": desc,
        "envelopePic": envelopePic,
        "fresh": fresh,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "origin": origin,
        "originId": originId,
        "prefix": prefix,
        "projectLink": projectLink,
        "publishTime": publishTime,
        "superChapterId": superChapterId,
        "superChapterName": superChapterName,
        "tags": tags,
        "title": title,
        "type": type,
        "userId": userId,
        "visible": visible,
        "zan": zan,
      };
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

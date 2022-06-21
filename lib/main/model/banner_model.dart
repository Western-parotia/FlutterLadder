class BannerModel {
  final String desc;
  final int id;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  BannerModel.fromJson(Map<String, dynamic> map)
      : desc = map["desc"],
        id = map["id"],
        imagePath = map["imagePath"],
        isVisible = map["isVisible"],
        order = map["order"],
        title = map["title"],
        type = map["type"],
        url = map["url"];
}

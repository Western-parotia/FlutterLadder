import 'package:flutter/cupertino.dart';

/// Generate by [resource_generator](https://github.com/CaiJingLong/flutter_resource_generator) library.
/// PLEASE DO NOT EDIT MANUALLY.

class AssetsUtils {
  static Widget loadImage(String name) {
    return Image.asset(ImagesPath.wrapLocalImage(name));
  }

  static Widget loadImageWH(String name, double w, double h) {
    return Image.asset(ImagesPath.wrapLocalImage(name), width: w, height: h);
  }
}

class ImagesPath {
  const ImagesPath._();

  static String wrapLocalImage(String name) {
    return "assets/images/" + name;
  }

  static String navBackGray = wrapLocalImage("sl_nav_back_gray.png");
}

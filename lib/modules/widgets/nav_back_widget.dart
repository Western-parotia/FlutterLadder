import 'package:flutter/material.dart';

import '../../global/common_size.dart';
import '../../global/images_path.dart';

// 导航栏左边返回按钮组件
class NavBackWidget extends StatefulWidget {
  const NavBackWidget({Key? key, required this.navBackHandleBlock})
      : super(key: key);
  final Function navBackHandleBlock; //final变量可以在构造函数参数列表或者初始化列表中初始化。
  @override
  State<NavBackWidget> createState() => _NavBackWidgetState();
}

class _NavBackWidgetState extends State<NavBackWidget> {
  // 返回事件回调
  @override
  Widget build(BuildContext context) {
    return IconButton(
        //splashColor,highlightColor 设置透明去除默认效果
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        icon: Image.asset(
          ImagesPath.navBackGray,
          width: CommonSize.appBarImageSize,
          height: CommonSize.appBarImageSize,
        ),
        onPressed: () {
          widget.navBackHandleBlock();
        });
  }
}

import 'package:flutter/material.dart';

// 主Widget
class HDMinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDMinePageState();
}

// 状态类
class HDMinePageState extends State<HDMinePage> {
  List<String> listItems = ["收藏","黑夜模式","色彩主体","设置","检查更新"];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView (
      slivers: <Widget>[
      // AppBar，包含一个导航栏.
      SliverAppBar (
      pinned: true, // 滑动到顶端时会固定住
      expandedHeight: 200.0,
         // flexibleSpace:getTopContainer(),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(''),
        background: getTopContainer(),
      ),
      )],
    );
  }

   Widget getTopContainer() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(top:0,left: 0,right: 0,bottom: 0,child: Image.asset(
          "images/icon_flutter.png",
          fit: BoxFit.cover,
        )),
        Positioned(top:100,width:50,height:50,child: Container(color: Colors.red)),
        const Positioned(top:170,width:100,height:20,child: Text("你好",textAlign: TextAlign.center,)),
      ],
    );
   }
}
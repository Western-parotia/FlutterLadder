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
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(''),
        background: getTopHeader(),
      ),
      )],
    );
  }

  // 顶部 headerView
   Widget getTopHeader () {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(top:0,left: 0,right: 0,bottom: 0,child: Image.asset(
          "images/hd_update_head.jpg",
          fit: BoxFit.cover,
        )),
        Positioned(top:120,width:80,height:80,child:InkWell(
          child: getIconButton(),
          onTap: (){
            print("这个是封装的按钮");
          },
        )),
        //const Positioned(top:170,width:100,height:20,child: Text("你好",textAlign: TextAlign.center,)),
      ],
    );
   }
   Widget getIconButton () {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.red,
      child: Column(
        // fromLTRB: 左 上 右 下
        children: [
          Padding(padding: EdgeInsets.only(top: 5),child:
          Image.asset("images/hd_arrow_right.png"),),
          Padding(padding: EdgeInsets.only(top: 5),child: Text("点击登录",textAlign: TextAlign.center,),)
        ],
      ),
    );
   }
   // 下面列表视图

}
import 'package:flutter/material.dart';

/// 主Widget类
class HDMinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDMinePageState();
}

/// HDMinePage状态管理类
class HDMinePageState extends State<HDMinePage> {
  /// 列表标题数组
  List<String> titles = const ["收藏","黑夜模式","色彩主体","设置","检查更新"];

  /// 列表图标数组
  List<Icon> icons = const [Icon(Icons.favorite,color:Colors.red,),
    Icon(Icons.enhance_photo_translate,color:Colors.red,),
    Icon(Icons.family_restroom,color:Colors.red,),
    Icon(Icons.settings,color:Colors.red),
    Icon(Icons.update,color:Colors.red,)];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView (
      slivers: <Widget>[
        ///  SliverAppBar 和  SliverToBoxAdapter 互斥，SliverToBoxAdapter没有导航
    /**
      // AppBar，包含一个导航栏.
      SliverAppBar (
          pinned: true, // 滑动到顶端时会固定住
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: getTopHeaderView(),
          ),
      ),
        */
        /// 自定义视图
        SliverToBoxAdapter(
          child: getTopHeaderViewV2(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return getListView(index);
          }, childCount: titles.length),
        )
      ],
    );
  }

  /// 顶部 headerView
   Widget getTopHeaderView () {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(top:0,left: 0,right: 0,bottom: 0,child: Image.asset(
          "images/hd_update_head.jpg",
          fit: BoxFit.cover,
        )),
        Positioned(top:110,width:80,height:90,child:InkWell(
          child: getIconButton(),
          onTap: (){
            print("这个是封装的按钮");
          },
        )),
      ],
    );
   }

   /// 顶部 headerView 第二个版本
   Widget getTopHeaderViewV2 () {
    return Container(
      alignment: Alignment.topCenter,
      height: 220,
      child: getTopHeaderView(),
    );
   }

   /// 顶部 headerView上面登录图标、文案
   Widget getIconButton () {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        // fromLTRB: 左 上 右 下
        children: [
          Padding(padding: EdgeInsets.only(top: 5,bottom: 5),child:
          getCirculImage(),),
          Text("点击登录",textAlign: TextAlign.center,)
        ],
      ),
    );
   }

   /// 顶部 headerView头像Icon
   Widget getCirculImage () {
     return ClipOval(
       child: Image.asset(
         "images/hd_gaoyuanyuan.jpg",
         width: 60,
         height: 60,
         fit: BoxFit.cover,
       ),
     );
   }

   /// 下面列表视图--Cell
   Widget getListView (int index) {
    return SizedBox (
      height: 50,
      child: Row (
        children: [
          Padding(padding: EdgeInsets.only(left: 15,right: 15),child:icons[index]),
          Text(titles[index]),
          Expanded(child: Container()),
          Container(margin: EdgeInsets.only(right: 10),width: 20,height: 25,child:Image.asset("images/hd_arrow_right.png"),)
        ],
      ),
    );
  }
}
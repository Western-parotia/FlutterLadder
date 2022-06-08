//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 主Widget
class HDHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDHomePageState();
}

// 状态类
class HDHomePageState extends State<HDHomePage> {
  List<String> listItems = ["收藏","黑夜模式","色彩主体","设置","检查更新"];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
           slivers: [
              SliverToBoxAdapter(
                child: getTopBannerView(),
              ),
             SliverList(
               delegate: SliverChildBuilderDelegate((content, index) {
                 return getHomeItem(index);
               }, childCount: listItems.length),
             )
           ],
    );

  }
  Widget getTopBannerView () {
    return Container(
      height: 200,
      color: Colors.red,
    );
  }
  Widget getHomeItem(int index) {
    return Column(
      children: [
        SizedBox(height: 15),
        getAvatarNameWidget(),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Text("你好啊那水电费；",style: TextStyle(color: Colors.grey),textAlign: TextAlign.left,),
        ),
        SizedBox(height: 10),
        getBottomLikeWidget(),
        SizedBox(height: 10),
        Container(margin: EdgeInsets.only(left: 20,right: 20),color: Colors.grey,height: 1,)
      ],
    );
  }
  // 头像 名字 发表时间Widget
  Widget getAvatarNameWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20,right: 5),
          child: ClipOval(
              child: Image.asset("images/hd_gaoyuanyuan.jpg",
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
          )
        ),
        Text("你好",style: TextStyle(color: Colors.grey),),
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Text("2022-06-07",style: TextStyle(color: Colors.grey),),
        )
    ],
    );
  }

  // 底部置顶，喜欢Widget
  Widget getBottomLikeWidget () {
      return Row (
          children: [
             Container(
               width: 30,
               height: 18,
               alignment: Alignment.center,
               decoration:BoxDecoration(border: Border.all(color: Colors.blue,width: 1.0)),
                   //borderRadius: BorderRadius.circular(15)),
               margin: EdgeInsets.only(left: 20,right: 5),
               child: Text("置顶",style: TextStyle(color: Colors.blue,fontSize:10),),
             ),
             Text("你好",style: TextStyle(color: Colors.grey),),
             Expanded(child: Container()),
             Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(Icons.favorite,color: Colors.red,),
             )
          ],
      );
  }

  // 获取列表Cell
  Widget getListItem (int index) {
    String textString = listItems[index];
    return Stack(
      children: [
        const Positioned(left: 20,top: 10,width: 30,height: 30,child: Icon(Icons.favorite,color: Colors.red)
        ),
         Positioned(left: 70,top: 15,width: 80,height: 20,child: Text(textString)
        ),
        Positioned(right: 15,top: 17,width: 16,height: 16,child: Image(width: 16,height: 16,image: AssetImage("images/ic_arrow_right.png"),)
        ),

        Positioned(left: 15,top: 50,right: 15,height: 1,child: Container(
          color: Colors.grey,
        ),),
      ],
    );
  }

}


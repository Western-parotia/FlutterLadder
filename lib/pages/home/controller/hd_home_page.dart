//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:wanandroid_app/net/api.dart';
import 'package:wanandroid_app/net/mj_http_tool.dart';
import 'package:wanandroid_app/net/api.dart';
import 'package:wanandroid_app/net/mj_http_tool.dart';
// 主Widget
class HDHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDHomePageState();
}
// 状态类
class HDHomePageState extends State<HDHomePage> {
  List<String> listItems = ["收藏","黑夜模式","色彩主体","设置","检查更新"];
  List<String> imageList = ["https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
  ];
  @override
  void initState() {
    super.initState();
    httpGetData(1);
  }
  void httpGetData(int page) {
// result 请求数据返回的Json字符串
    MJHttpTool(url: Api.question(page)).requestData((dynamic result) {
      print("$result");
    },(dynamic error) {

    }, () {

    });
  }

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
      color: Colors.blue,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          // 配置图片地址
          return Image.network(imageList[index],fit: BoxFit.fill,);
        },
        onTap: (int index) {
          print("轮播图点击索引：$index");
        },
        // 配置图片数量
        itemCount: imageList.length ,
        // 底部分页器
        pagination: SwiperPagination(),
        // 左右箭头
        //control: SwiperControl(),
        // 无限循环
        loop: true,
        // 自动轮播
        autoplay: true,
      ),
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
}


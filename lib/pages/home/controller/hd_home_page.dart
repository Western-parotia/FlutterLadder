

import 'dart:convert';                                  // json 解析内置库
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';          // 轮播图
import 'package:wanandroid_app/net/api.dart';           // http请求
import 'package:wanandroid_app/net/mj_http_tool.dart';
import 'package:wanandroid_app/pages/home/model/home_model.dart';  // 封装的http请求类
import 'package:wanandroid_app/pages/webView/hd_web_page.dart';
// 主Widget
class HDHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDHomePageState();
}
// 状态类
class HDHomePageState extends State<HDHomePage> {
  List<String> imageList = ["https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=2862534777,914942650&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
  ];
  List<HomeModel> dataArray = [];
  // 当前页
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    httpGetData(1);
  }
  void httpGetData(int page) {
// result 请求数据返回的Json字符串
    MJHttpTool(url: Api.question(page)).requestData((dynamic result) {
      // json 转字典
      Map<String, dynamic> jsonMap = json.decode(result);
      // datasList 字典数组,非model
      List<dynamic> datasList = jsonMap["data"]["datas"];
      // 当前页
      currentPage = jsonMap["data"]["curPage"];
      // 字典数组转Model
      if (datasList.isNotEmpty) {
        for (var dict in datasList) {
            dataArray.add(HomeModel.fromJson(dict));
        }
      } else {
         if (currentPage == 1) { // 无数据

         } else { // 没有更多

         }
      }
      // 刷新数据
      setState((){
      });
     // print("$jsonMap");
    },(dynamic error) { // 网络错误需要单独处理

    }, () { // 请求完成，可以做些处理

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: getTopBannerView(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((content, index) {
              return getHomeItem(index);
            }, childCount: dataArray.length),
          )
        ],
      ),
    );
   // return

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
    HomeModel model = dataArray[index];
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HDWebViewPage(url: model.link,title: "WebView",isLocalUrl: false,);
          }));
      },
      child: Column(
        children: [
          SizedBox(height: 15),
          getAvatarNameWidget(model),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Text(model.desc,style: TextStyle(color: Colors.grey),textAlign: TextAlign.left,),
          ),
          SizedBox(height: 10),
          getBottomLikeWidget(model),
          SizedBox(height: 10),
          Container(margin: EdgeInsets.only(left: 20,right: 20),color: Colors.grey,height: 1,)
        ],
      ),
    );
  }
  // 头像 名字 发表时间Widget
  Widget getAvatarNameWidget(HomeModel model) {
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
        Text(model.author != null ? "作者：${model.author}":"",style: TextStyle(color: Colors.grey),),
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Text(model.niceShareDate,style: TextStyle(color: Colors.grey),),
        )
    ],
    );
  }

  // 底部置顶，喜欢Widget
  Widget getBottomLikeWidget (HomeModel model) {
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
             Text(model.superChapterName,style: TextStyle(color: Colors.grey),),
             Expanded(child: Container()),
             Container(
               margin: EdgeInsets.only(right: 5),
               child: Text("点赞数量：${model.zan}"),
             ),
             Container(
                margin: EdgeInsets.only(right: 20),
                child: InkWell(child: Icon(Icons.favorite,color: Colors.red,),onTap: (){
                  model.zan = model.zan + 1;
                  print("点赞了");
                  // 刷新数据
                  setState((){
                  });
                },),
             )
          ],
      );
  }
}


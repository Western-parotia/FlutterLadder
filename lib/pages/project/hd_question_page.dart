
import 'package:flutter/material.dart';
// Controller
import 'package:wanandroid_app/pages/webView/hd_web_page.dart';
// Model工具类
import 'dart:convert';                                            // json 解析
import 'package:wanandroid_app/net/api.dart';                     // api接口类
import 'package:wanandroid_app/net/mj_http_tool.dart';            // http请求工具类
import 'package:wanandroid_app/pages/home/model/home_model.dart'; // 数据model

class HDQuestionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDQuestionPageState();
}

class HDQuestionPageState extends State<HDQuestionPage> {
  int currentPage = 0;       // 当前页
  List dataArray = [];       // 数据源数组
  bool no_more_data = false; // 没有更多数据
  ScrollController _scrollController = ScrollController(); // listview 的滚动控制器
  @override
  void initState() {
    super.initState();
    httpGetQuestionData(currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        currentPage ++;
        httpGetQuestionData(currentPage);
      }
    });
  }
  // 请求数据
  void httpGetQuestionData(int page) {
      MJHttpTool(url: Api.question(page)).requestData((dynamic result) {
      // json 转字典
      Map<String, dynamic> jsonMap = json.decode(result);
      // datasList 字典数组,非model
      List<dynamic> datasList = jsonMap["data"]["datas"];
      //print("当前页数：$page");
      //print("请求数据：$datasList");
      // 当前页
      currentPage = jsonMap["data"]["curPage"];
      if (currentPage == 0) {
        dataArray.clear();
        no_more_data = false;
      }
      // 字典数组转Model
      if (datasList.isNotEmpty) {
        for (var dict in datasList) {
          dataArray.add(HomeModel.fromJson(dict));
        }
        print("加载到数据，刷新页面");
      } else {
        if (currentPage == 0) { // 无数据

        } else { // 没有更多
          no_more_data = true;
          print("没有更多啦");
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
    return RefreshIndicator(
        child: RepaintBoundary( // RepaintBoundary 包裹提高性能
          // itemBuilder 是一个返回Widget的Function
          child: ListView.separated(
            itemBuilder: (BuildContext context,int index){
              // 自定义上拉加载，网络上建议这么写
              if (index == dataArray.length - 1) {
                return Column(
                  children: [
                    getItemBuilder(index),
                    getLoadMoreWidget()
                  ],
                );
              } else {
                return Column(
                  children: [
                    getItemBuilder(index),
                  ],
                );
              }
            },
            controller: _scrollController,
            separatorBuilder: (BuildContext context, int index) => Container(
              height: 5,
            ),
            itemCount: dataArray.length,
          ),
        ),
        onRefresh: () async {
              setState ( (){
                  currentPage = 1;
                  httpGetQuestionData(currentPage);
              }
          );
        });
  }
  // 自定义列表项
  Widget getItemBuilder(int index) {
    HomeModel homeModel = dataArray[index];
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HDWebViewPage(url: homeModel.link,title: "${homeModel.title}",isLocalUrl: false,);
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
          child: getQuestioinItem(index),
        ),
      ),
    );
  }

  Widget getQuestioinItem(int index) {
    HomeModel homeModel = dataArray[index];
      return Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
              child: Row(
                  children: [
                    Text(homeModel.niceDate),
                    Expanded(child: Container(),),
                    getRightTagsWidget(index), // Tags 是动态的Widget数组
                    // Container(decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5), color: Colors.blue),
                    //     child:Text("本站发布",style: TextStyle(color: Colors.white),) ,
                    //     height: 25,
                    //     margin: EdgeInsets.only(right: 10),
                    //   padding: EdgeInsets.only(left: 8,right: 8),
                    //   alignment: Alignment.center,
                    // ),
                    // Container(decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5),color: Colors.blue),
                    //   child:Text("问答",style: TextStyle(color: Colors.white)) ,
                    //   height: 25,
                    //   margin: EdgeInsets.only(right: 10),
                    //   alignment: Alignment.center,
                    //   padding: EdgeInsets.only(left: 8,right: 8),
                    // ),
                  ],
              ),),
            Container(padding: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),alignment: Alignment.centerLeft,
              child: Text(homeModel.title,style: TextStyle(color: Colors.black,fontSize:18),),),
            Padding(padding: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 10),
              child: Row(
                children: [
                  Text(homeModel.author != null ? "作者：${homeModel.author!}" : "作者：无名"),
                  Expanded(child: Container()),
                  InkWell(child: Icon(Icons.favorite,color: Colors.red,),onTap: (){
                    homeModel.zan = homeModel.zan + 1;
                    print("点赞了");
                    // 刷新数据
                    setState((){
                    });
                  },),
                  SizedBox(width: 5,),
                  Text("${homeModel.zan}")
                ],
              ),)
          ],
      );
  }
 // 获取右边标签Widget容器
  Widget getRightTagsWidget (int index) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: getTags(index),
      ),
    );
  }
  // 获取标签Widget数组
  dynamic getTags (int index) {
    HomeModel homeModel = dataArray[index];
    List<Widget> tags = [];
    for (var item in homeModel.tags) {
      tags.add(Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),color: Colors.blue),
        child:Text(item.name,style: TextStyle(color: Colors.white)) ,
        height: 25,
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8,right: 8),
      ));
    }
    return tags;
  }
  // 自定义上拉加载组件
  Widget getLoadMoreWidget() {
    return Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getLastWidget()
          ),)
    );
  }
  // 获取数据源最后一个Widget
  dynamic getLastWidget() {
    if (no_more_data) {
      return [Text("没有更多数据啦"),];
    } else {
      return [Text("正在加载更多..."), CircularProgressIndicator(strokeWidth: 1.0,)];
    }
  }
}
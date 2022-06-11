
import 'package:flutter/material.dart';
import 'package:wanandroid_app/pages/project/hd_question_page.dart';
import 'package:wanandroid_app/pages/project/hd_recommend_page.dart';

class HDProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDProjectPageState();
}

// 需实现 SingleTickerProviderStateMixin
class HDProjectPageState extends State<HDProjectPage> with SingleTickerProviderStateMixin {
  List tabArry = ["问答","推荐"];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: tabArry.length, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabArry.length,
      child: Scaffold(
        appBar: getCustomerAppBar(context),
        body: TabBarView(
          controller: _tabController,
          children: [HDQuestionPage(),HDRecommendPage()],
        )
      ),
    );
  }
  // 自定义顶部导航条
  PreferredSizeWidget getCustomerAppBar (BuildContext context) {
    return PreferredSize(
        child: Container(
          alignment: Alignment.center,
          child: TabBar(
          //isScrollable属性会使Tab居中
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.white,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.only(left: 10,right: 10,top: 42,bottom: 5),
          indicatorWeight: 5,
          labelStyle: const TextStyle(fontSize: 20),
          tabs: getTabs(),
        ),
          color: Colors.blue,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),),
        preferredSize: Size(double.infinity,56));
  }

   dynamic getTabs () {
    List<Widget> tabArr = [];
    for (var text in tabArry) {
       Tab tab = Tab(text: text);
       tabArr.add(tab);
    }
    return tabArr;
  }
}
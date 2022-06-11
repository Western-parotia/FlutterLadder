//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/pages/home/controller/hd_home_page.dart';
import 'package:wanandroid_app/pages/login/hd_login_page.dart';
import 'package:wanandroid_app/pages/mine/hd_mine_page.dart';
import 'package:wanandroid_app/pages/project/hd_project_page.dart';

class HDMainNavigator extends StatefulWidget {
  HDMainNavigator({Key? key}) : super(key:key);  // 构造方法
  @override
  State<StatefulWidget> createState() => HDMainNavigatorState();
}

// 状态管理类
class HDMainNavigatorState extends State<HDMainNavigator> {
  DateTime? _lastPressedAt; // 上次点击时间，WillPopScope 防止用户误触返回键而退出APP,当用户在1秒内点击两次返回按钮时，才认为是退出APP
  final appPages = [HDHomePage(),HDProjectPage(),HDMinePage()];
  var currentIndex = 0;

  @override
  void initState() {
    super.initState(); // widge 首次加载时调用，可做一些初始化事情，如状态初始化，订阅子Widget通知
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope (
       child: Scaffold(
         body: appPages[currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           items: const [BottomNavigationBarItem(label: "首页",icon: Icon(Icons.home)),
             BottomNavigationBarItem(label: "项目", icon: Icon(Icons.list)),
             BottomNavigationBarItem(label: "我的", icon: Icon(Icons.person))],
           currentIndex:currentIndex,
           fixedColor: Colors.orange,
           onTap: tapAction,
         )
       ),
       onWillPop: ()async {
         if (_lastPressedAt == null ||
             DateTime.now().difference(_lastPressedAt ?? DateTime.now()) >
                 const Duration(seconds: 1)) {
           _lastPressedAt = DateTime.now();
           //两次点击间隔超过1秒则重新计时
           return false;
         }
         return true;
       },
     );
  }

  void tapAction (int index){
    setState(() {
      currentIndex = index;
    });
  }
}
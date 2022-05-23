import 'package:flutter/material.dart';
import 'package:wanandroid_app/common/color_list.dart';
import 'package:wanandroid_app/routes/feed/feed_page.dart';
import 'package:wanandroid_app/routes/img/image_page.dart';
import 'package:wanandroid_app/routes/user/user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}

class _HomeState extends State<MainPage> {
  var _currentPageIndex = 0;

  final List<Widget> _pages = [
    FeedPage(),
    ImagePage(),
    UserPage(),
  ];

  void _onTaped(index){
    setState(() {
      _currentPageIndex = index;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: MColors.cardBackground,
        currentIndex: _currentPageIndex,
        onTap:_onTaped,
        elevation: 10,
        selectedIconTheme:const IconThemeData(
          color: MColors.primaryColorAccent,
          size: 25
        ),
        unselectedIconTheme:const IconThemeData(
            color: MColors.primaryColorDark,
            size: 20
        ),
      selectedItemColor: MColors.primaryColorAccent,
      unselectedItemColor: MColors.primaryColorDark,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_rounded),
            label: "资讯",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "图片"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "用户"
          ),
        ],
      ),
      body:_pages[_currentPageIndex]
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/modules/account/account_page.dart';
import 'package:wanandroid_app/modules/home/home_page.dart';
import 'package:wanandroid_app/modules/project/project_page.dart';
import 'package:wanandroid_app/modules/structure/structure_page.dart';
import 'package:wanandroid_app/modules/wechat_account/wechat_account_page.dart';

class TabBarBottom extends StatefulWidget {
  const TabBarBottom({Key? key}) : super(key: key);

  @override
  State<TabBarBottom> createState() => _TabBarBottomState();
}

class _TabBarBottomState extends State<TabBarBottom> {
  List<Widget> pages = <Widget>[
    const HomePage(),
    const ProjectPage(),
    const WechatAccountPage(),
    const StructurePage(),
    const AccountPage()
  ];
  late PageController _pageController;
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (ctx, index) => pages[index],
        itemCount: pages.length,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), label: '项目'),
          BottomNavigationBarItem(icon: Icon(Icons.group_work), label: '公众号'),
          BottomNavigationBarItem(icon: Icon(Icons.call_split), label: '体系'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_emoticon), label: '我的'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

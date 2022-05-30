import 'package:flutter/material.dart';

import '../../global/images_path.dart';
import '../login/login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.deepOrange,
            expandedHeight: 240,
            pinned:
                false, // 默认false 可以不设置  [floating], [pinned], [snap] 设置true、false，效果有所不同,可查看内部详情说明
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax, // 默认parallax 可以不设置，滚动折叠时的效果
              background: _HeaderWidget(),
            ),
          ),
          _MenusWidget()
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Hero(
              tag: "_logo",
              child: _logoElement(),
            ),
          ),
          Container(
            //这里也可以使用Padding，或者SizedBox(height: 20)加个间距
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () => _gotoLoginPage(context),
              child: const Text(
                "点击登录",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _gotoLoginPage(BuildContext context) {
    // Navigator.of(context).push(CupertinoPageRoute(
    //    builder:(_) =>LoginWidget() ,
    // ));
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const LoginPage()));
  }
}

Widget _logoElement() {
  return Image.asset(
    ImagesPath.wrapLocalImage("user_avatar.png"),
    fit: BoxFit.cover,
    colorBlendMode: BlendMode.colorDodge,
    width: 80,
    height: 80,
    color: Colors.deepPurpleAccent,
  );
}

class _MenusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate(_menus()),
      ),
    );
  }

  List<Widget> _menus() {
    final lws = <Widget>[];
    for (int i = 0; i < 100; i++) {
      lws.add(_createMenu(i));
    }
    return lws;
  }

  //ListTile 可以做个封装传index 标题放入一个数组中根据index取值
  Widget _createMenu(int index) {
    var iconColor = Colors.deepPurpleAccent;
    late ListTile? listTile;
    switch (index) {
      case 0:
        listTile = ListTile(
          title: const Text("收藏"),
          onTap: () => {},
          leading: Icon(
            Icons.favorite_border,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
        break;
      case 1:
        listTile = ListTile(
          title: const Text("黑夜模式"),
          onTap: () => {},
          leading: Icon(
            Icons.dark_mode,
            color: iconColor,
          ),
          trailing: Switch(
            value: false,
            onChanged: (v) => {},
          ),
        );
        break;
      case 2:
        listTile = ListTile(
          title: const Text("彩色主题"),
          onTap: () => {},
          leading: Icon(
            Icons.color_lens,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
        break;
      case 3:
        listTile = ListTile(
          title: const Text("设置"),
          onTap: () => {},
          leading: Icon(
            Icons.settings,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
        break;
      case 4:
        listTile = ListTile(
          title: const Text("检查更新"),
          onTap: () => {},
          leading: Icon(
            Icons.install_mobile,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
        break;
      default:
        listTile = ListTile(
          title: Text("title:$index"),
          onTap: () => {},
          leading: Icon(
            Icons.animation,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
    }

    return listTile;
  }
}

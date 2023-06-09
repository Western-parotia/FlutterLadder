import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_app/modules/mine/controller/login_controll.dart';
import 'package:wanandroid_app/modules/mine/learn_items/state_manage_by_parent.dart';

import '../../global/images_path.dart';
import '../../utils/log_utils.dart';
import 'learn_items/getx_simple.dart';
import 'learn_items/state_manage_by_self.dart';
import 'login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: Colors.deepOrange,
              expandedHeight: 240,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: _HeaderWidget(),
              )),
          _MenusWidget()
        ],
      ),
    );
  }
}

class _HeaderWidgetState extends State<_HeaderWidget> {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(tag: "_logo", child: ClipOval(child: _logoElement())),
          Container(
              padding: const EdgeInsets.only(top: 20),
              child: loginController.isLogin
                  ? _hasLogin(context)
                  : _unLogin(context))
        ],
      ),
    );
  }

  Widget _unLogin(BuildContext context) {
    return InkWell(
      onTap: () => _gotoLoginPage(context),
      child: const Text(
        "点击登录",
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _hasLogin(BuildContext context) {
    return Text(
      loginController.userName,
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
    );
  }

  void _gotoLoginPage(BuildContext context) {
    // Navigator.of(context).push(CupertinoPageRoute(
    //    builder:(_) =>LoginWidget() ,
    // ));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const LoginPage()))
        .then((value) {
      Log.i("==============$value");
      setState(() {});
    });
  }
}

class _HeaderWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeaderWidgetState();
}

Widget _logoElement() {
  return Image.asset(
    ImagesPath.wrapLocalImage("user_avatar.png"),
    fit: BoxFit.cover,
    colorBlendMode: BlendMode.dstIn,
    width: 80,
    height: 80,
    color: Colors.lightBlue,
  );
}

class _MenusWidget extends StatelessWidget {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
      case 5:
        listTile = ListTile(
          title: const Text("状态管理:子widget独自管理"),
          onTap: () => {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (BuildContext context) {
              return const TapboxA();
            }))
          },
          leading: Icon(
            Icons.adjust,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
        break;
      case 6:
        listTile = ListTile(
          title: const Text("状态管理:父管子"),
          onTap: () => {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (BuildContext context) {
              return const ParentWidget();
            }))
          },
          leading: Icon(
            Icons.adjust,
            color: iconColor,
          ),
          trailing: const Icon(Icons.chevron_right),
        );
        break;
      case 7:
        listTile = ListTile(
          title: const Text("状态管理:getX 计数器Plus"),
          onTap: () => {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (BuildContext context) {
              return CalculatePageA();
            }))
          },
          leading: Icon(
            Icons.adjust,
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

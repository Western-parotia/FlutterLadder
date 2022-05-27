import 'package:flutter/material.dart';

import '../../global/images_path.dart';

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
              title: const Center(
                child: Text("我的"),
              ),
              actions: <Widget>[
                // IconButton(onPressed: ()=>{},
                //     icon: const Icon(Icons.exit_to_app))
              ],
              backgroundColor: Colors.deepOrange,
              expandedHeight: 200 + MediaQuery.of(context).padding.top,
              pinned: true,
              flexibleSpace: _HeaderWidget()),
          _MenusWidget()
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
            color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Image.asset(
                  ImagesPath.wrapLocalImage("user_avatar.png"),
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.colorDodge,
                  width: 80,
                  height: 80,
                  color: Colors.deepPurpleAccent,
                ),
                InkWell(
                  onTap: () => _gotoLoginPage(context),
                  child: const Text("点击登录"),
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
        .push(MaterialPageRoute<void>(builder: (_) => LoginWidget()));
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      color: Colors.deepOrange,
      child: const Center(
        child: Text("login"),
      ),
    );
  }
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

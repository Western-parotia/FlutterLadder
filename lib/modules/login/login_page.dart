import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../global/images_path.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const double ROW_GAP = 40;

  @override
  Widget build(BuildContext context) {
    final titleBarHeight = 56 + MediaQuery.of(context).padding.top;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                flex: 0,
                child: Container(
                  height: 300,
                  color: Colors.lightBlue,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.shade200,
                )),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              // 关闭键
              height: titleBarHeight,
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: MediaQuery.of(context).padding.left),
                color: Colors.black26,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: CloseButton(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              // logo
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Hero(
                        tag: "_logo",
                        child: SizedBox(
                          height: 150,
                          width: 110,
                          child: Image.asset(
                            ImagesPath.wrapLocalImage("login_logo.png"),
                            colorBlendMode: BlendMode.srcIn,
                            fit: BoxFit.fitWidth,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
                // color: Colors.amber, // color 与 decoration 互斥
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(10),
                decoration: createCardDecoration(context),
                child: _LoginWidget()),
            const SizedBox(
              height: ROW_GAP,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                    width: 100,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    "第三方登录",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                    width: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ROW_GAP,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              InkWell(
                onTap: () => {},
                child: AssetsUtils.loadImageWH("logo_wechat.png", 40, 40),
              ),
              const SizedBox(
                width: 100,
              ),
              InkWell(
                onTap: () => {},
                child: AssetsUtils.loadImageWH("logo_weibo.png", 40, 40),
              ),
            ])
          ],
        )
      ],
    ));
  }
}

Decoration createCardDecoration(BuildContext context) {
  return ShapeDecoration(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))),
      color: Theme.of(context).cardColor,
      // color: Colors.deepPurpleAccent,
      shadows: [
        BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(40),
            // color: Colors.red,
            offset: const Offset(2.0, 2.0),
            blurRadius: 5,
            spreadRadius: 0)
      ]);
}

class _LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<_LoginWidget> {
  var _name = "";
  var _pwd = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(
            label: Text("用户名"),
            hintText: "点击输入",
            prefix: Icon(Icons.person, color: Colors.blue, size: 20),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            label: Text("密码"),
            hintText: "点击输入",
            prefix: Icon(Icons.person, color: Colors.blue, size: 20),
          ),
        ),

      ],
    );
  }
}

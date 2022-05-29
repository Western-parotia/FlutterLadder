import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../global/images_path.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                          height: 130,
                          width: 100,
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
            )
          ],
        )
      ],
    ));
  }
}

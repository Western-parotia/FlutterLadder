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
        //避免键盘弹出时，出现布局溢出（也可使用滚动布局处理，与android 同理）
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                    // Container固定高度可以不使用Expanded
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
                  // 这里可以不使用SizedBox，直接设置Container中的height为titleBarHeight 即可
                  // 关闭键
                  height: titleBarHeight,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: MediaQuery.of(context).padding.left),
                    color: Colors.black26,
                    child: const Align(
                      // 这里可以不使用Align，Container本身有alignment属性，直接设置Alignment.centerLeft即可
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
                    // 这里可以不使用Align，Container本身有alignment属性，直接设置Alignment.topCenter即可
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
                    padding: const EdgeInsets.all(20),
                    decoration: createCardDecoration(context),
                    child: _LoginWidget()),
                const SizedBox(
                  height: ROW_GAP,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      // 这里可以不使用Align，Container本身有alignment属性
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
                      // 这里可以不使用Align，Container本身有alignment属性
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
                Row(
                    // InkWell多个的情况可封装，一两个可直接写
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => {},
                        child:
                            AssetsUtils.loadImageWH("logo_wechat.png", 40, 40),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      InkWell(
                        onTap: () => {},
                        child:
                            AssetsUtils.loadImageWH("logo_weibo.png", 40, 40),
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
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            label: Text("用户名"),
            prefixIcon: Icon(Icons.person, color: Colors.blue, size: 20),
            suffixIcon: Icon(Icons.close, color: Colors.grey, size: 20),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            label: Text("密码"),
            hintText: "6-18位",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.lock, color: Colors.blue, size: 20),
            suffixIcon: Icon(Icons.remove_red_eye_outlined,
                color: Colors.grey, size: 20),
          ),
        ),
        InkWell(
            // 这里可以先设置间距，在设置InkWell，否则点击上面的top 50也会触发点击事件
            onTap: () => {},
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              height: 50,
              decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              child: const Center(
                // 可以不使用Center  Container本身的alignment属性即可
                child: Text(
                  "登录",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("还没有账号?",
                style: TextStyle(color: Colors.black45, fontSize: 15)),
            InkWell(
              onTap: () => {},
              child: const Text("去注册",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 15)),
            )
          ],
        )
      ],
    );
  }
}

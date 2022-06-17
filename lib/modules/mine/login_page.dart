import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_app/modules/mine/mode/userinfo_model.dart';
import 'package:wanandroid_app/net/NetRepository.dart';
import 'package:wanandroid_app/net/http_client.dart';

import '../../global/images_path.dart';
import '../../utils/log_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const double rowGap = 40;

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
                Container(
                  height: 300,
                  color: Colors.lightBlue,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey.shade200,
                    )),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  // 关闭键
                  height: titleBarHeight,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: MediaQuery.of(context).padding.left),
                  color: Colors.black26,
                  alignment: Alignment.centerLeft,
                  child: const CloseButton(
                    color: Colors.white,
                  ),
                ),
                Container(
                  // logo
                  padding: const EdgeInsets.only(top: 30),
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
                Container(
                  // color: Colors.amber, // color 与 decoration 互斥
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(20),
                    decoration: createCardDecoration(context),
                    child: _LoginWidget()),
                const SizedBox(
                  height: rowGap,
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
                  height: rowGap,
                ),
                Row(
                  //Lulu: InkWell多个的情况可封装，一两个可直接写:Zhusw:下面是两个独立按钮
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

///但这里的目标不是提供最佳实践，而是展示不同的实现方式，探索Form的操作性
///下面分别使用了 TextFormField 的 Controller , onSaved（）+ validator 的使用
class _LoginState extends State<_LoginWidget> {
  var _account = "";
  var _pwd = "";
  var visiblePWD = true;
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();

  void _login() {
    WanAndroidRepository.login(_account, _pwd)
        .thenObj((data) => UserinfoModel.fromJson(data), onSuccess: (v) {
      print("v:${v.username}");
      Fluttertoast.showToast(msg: "登录成功:${v.username}");
    }, onError: (e, s) {
      Fluttertoast.showToast(msg: s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _accountController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (text) {
              Log.i("onSaved :账号:$text");
              _account = text!;
            },
            validator: (text) {
              Log.i("validator :账号:$text");
              return text!.trim().length >= 4 ? null : "账号最少4个字符";
            },
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              label: const Text("账号"),
              labelStyle: const TextStyle(color: Colors.blue),
              prefixIcon:
                  const Icon(Icons.person, color: Colors.blue, size: 20),
              suffixIcon: InkWell(
                onTap: () {
                  _accountController.clear();
                },
                child: const Icon(Icons.close, color: Colors.grey, size: 20),
              ),
            ),
          ),
          TextFormField(
              onSaved: (text) {
                Log.i("onSaved :密码:$text");
                _pwd = text!;
              },
              validator: (text) {
                Log.i("validator :密码:$text");
                final t = text!.trim();
                return t.length >= 6 && t.length <= 18 ? null : "密码为6~18个字符";
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: visiblePWD,
              decoration: InputDecoration(
                label: const Text("密码"),
                hintText: "6-18位",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon:
                    const Icon(Icons.lock, color: Colors.blue, size: 20),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      visiblePWD = !visiblePWD;
                    });
                  },
                  child: const Icon(Icons.remove_red_eye_outlined,
                      color: Colors.grey, size: 20),
                ),
              )),
          const SizedBox(
            height: 50,
          ),
          InkWell(
              onTap: () {
                var _formState = _formKey.currentState;
                if (null != _formState) {
                  if (_formState.validate()) {
                    _formState.save();
                    Log.i("onTap :account,$_account, pwd:$_pwd");
                    _login();
                  }
                }
              },
              child: Container(
                  height: 50,
                  decoration: const ShapeDecoration(
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  alignment: Alignment.center,
                  child: const Text(
                    "登录",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wanandroid_app/ext/string_ext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: 280,
              decoration: const BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)))),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 40),
            child: const Icon(
              Icons.close,
              size: 30,
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: const Icon(
                  Icons.android,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.flutter_dash,
                size: 10,
                color: Colors.white,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.blue, offset: Offset(1, 10), blurRadius: 20, spreadRadius: -20)]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.perm_identity,
                          color: Colors.blue,
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(labelText: "用户名", hintText: "请输入用户名", border: InputBorder.none),
                          ),
                        ))
                      ],
                    ),
                    const Divider(
                      color: Colors.blue,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: Colors.blue,
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: _controller,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: "密码", hintText: "请输入密码", border: InputBorder.none),
                          ),
                        ))
                      ],
                    ),
                    const Divider(
                      color: Colors.blue,
                    ),
                    Container(
                      decoration: ShapeDecoration(color: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500))),
                      margin: const EdgeInsetsDirectional.only(top: 20),
                      width: 200,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          "登录",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => "哈哈哈哈".toast(context),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("还没有账号？"),
                            Text(
                              "去注册",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        )),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, top: 20, right: 50),
                child: Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.grey,
                    )),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        "第三方登录",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: () => "哈哈哈2".toast(context),
                          child: const Icon(
                            Icons.wechat,
                            color: Colors.green,
                            size: 50,
                          )),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () => "哈哈哈3".toast(context),
                          child: const Icon(
                            Icons.wechat,
                            color: Colors.red,
                            size: 50,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

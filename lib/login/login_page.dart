import 'package:flutter/material.dart';

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
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)))),
            const Icon(
              Icons.close,
              color: Colors.white,
              size: 30,
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Icon(
                    Icons.android,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.hdr_on_rounded,
                  size: 40,
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.perm_identity,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                  labelText: "用户名", hintText: "用户名明么么么"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

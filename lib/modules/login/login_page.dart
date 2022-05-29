import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Flex(direction: Axis.vertical,
          children:  <Widget>[
            Expanded(
                flex: 0,
                child: Container(
                  height: 300,
                  color: Colors.lightBlue,

                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blueGrey,
                )),
          ],
        ),

      ],

    );
  }
}

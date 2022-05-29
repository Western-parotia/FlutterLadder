import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "_logo",
      child:Scaffold(
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
                  color: Colors.blueGrey,
                )),
          ],
        ),
        SizedBox(
          height: 56 + MediaQuery.of(context).padding.top,
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,left:MediaQuery.of(context).padding.left),
            color: Colors.black26,
            child:const Align(
              alignment: Alignment.centerLeft,
              child:CloseButton(
                color: Colors.white,
              ),
            ) ,
          ),
        )


      ],
    )

      )
    );

  }
}

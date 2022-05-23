// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/common/color_list.dart';
import 'package:wanandroid_app/routes/main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  void _goHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainPage(key: key)),
        (r) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 3000),(){
      _goHomePage(context);
    });
    return Scaffold(
        backgroundColor: MColors.pageBackground,
        body: Container(
            child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 40.0),
                child: Image.asset(
                  "images/icon_flutter.png",
                  width: 90.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: [
                    Text(
                      "Wanandroid·Flutter",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text(
                      "color by dribble",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "data by wanandroid.com",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}

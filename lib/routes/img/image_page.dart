import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/common/color_list.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                margin: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: const [
                    Text(
                      "图片页面",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}

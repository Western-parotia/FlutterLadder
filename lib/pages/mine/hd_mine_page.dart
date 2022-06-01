import 'package:flutter/material.dart';

// 主Widget
class HDMinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDMinePageState();
}

// 状态类
class HDMinePageState extends State<HDMinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color:Colors.orange,
        child: Text("我的"),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMyPage extends StatefulWidget {
  const MainMyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainMyState();
  }
}

class MainMyState extends State<MainMyPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("首页");
  }
}

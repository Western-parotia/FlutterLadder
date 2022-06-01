import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTwoPage extends StatefulWidget {
  const MainTwoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainTwoState();
  }
}

class MainTwoState extends State<MainTwoPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("首页");
  }
}

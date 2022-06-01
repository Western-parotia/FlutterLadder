import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainHomeState();
  }
}

class MainHomeState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Text("首页");
  }
}

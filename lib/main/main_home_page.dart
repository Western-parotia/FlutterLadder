import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainHomeState();
  }
}

class _MainHomeState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Text("首页");
  }
}

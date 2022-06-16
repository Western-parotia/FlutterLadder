import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTwoPage extends StatefulWidget {
  const MainTwoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainTwoState();
  }
}

class _MainTwoState extends State<MainTwoPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("二页");
  }
}

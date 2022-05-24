import 'package:flutter/material.dart';
import 'package:wanandroid_app/modules/tab_bar/tab_bar_bottom.dart';

void main() {
  runApp(const WanAndroidAPP());
}

class WanAndroidAPP extends StatelessWidget {
  const WanAndroidAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.red,
          primaryColorDark: Colors.deepOrange,
          primaryColorLight: Colors.blue),
      home: const TabBarBottom(),
    );
  }
}

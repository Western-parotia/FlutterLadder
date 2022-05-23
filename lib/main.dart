import 'package:flutter/material.dart';
import 'package:wanandroid_app/routes/splash_page.dart';
import 'package:wanandroid_app/common/color_list.dart';
import 'package:wanandroid_app/test/testpage1.dart';

void main() {
  runApp(const WanAndroidAPP());
  // runApp(
  //   MaterialApp(
  //     title: "widget test",
  //     home: Scaffold(
  //       appBar: AppBar(title: const Text("widget_test")),
  //       body: const TestPageViewPage(),
  //     )
  //   )
  // );
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
      home: const SplashPage(),
    );
  }
}

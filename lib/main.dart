import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_app/modules/tab_bar/tab_bar_bottom.dart';

import 'modules/mine/controller/login_controll.dart';

void main() {
  runApp(const WanAndroidAPP());
}

class WanAndroidAPP extends StatelessWidget {
  const WanAndroidAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.red,
          primaryColorDark: Colors.deepOrange,
          primaryColorLight: Colors.blue),
      home: const TabBarBottom(),
    );
  }
}

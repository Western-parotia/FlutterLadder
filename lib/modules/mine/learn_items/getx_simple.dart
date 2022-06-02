import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_app/ext/ext.dart';

/// 定义状态控制器
class CalculateController extends GetxController {
  ///声明需要可观察的状态属性 .obs
  var count = 0.obs;

  ///定义 修改状态的函数,节约dart没有编译层面的私有约束
  void plusOne() {
    count++;
    "plusOne:$count".logI("CalculateController");
  }
}

class CalculatePageA extends StatelessWidget {
  CalculatePageA({Key? key}) : super(key: key);

  //创建控制器
  final control = Get.put(CalculateController());

  //tag 方式
  // final control = Get.put(CalculateController(),tag: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //订阅更新
            Obx(() => Text("count:${control.count}",
                style: const TextStyle(fontSize: 30))),
            GestureDetector(
              onTap: () => control.plusOne(),
              child: Container(
                color: Colors.deepOrange,
                height: 100,
                width: 200,
                child:
                    const Text("click to add", style: TextStyle(fontSize: 30)),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Other();
              })),
              child: Container(
                color: Colors.green,
                height: 100,
                width: 300,
                child: Text("click to Other Page",
                    style: const TextStyle(fontSize: 30)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Other extends StatelessWidget {
  final CalculateController c = Get.find();

  // final CalculateController c = Get.find(tag:"");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Count:${c.count}",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

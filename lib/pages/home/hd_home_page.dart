//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 主Widget
class HDHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDHomePageState();
}

// 状态类
class HDHomePageState extends State<HDHomePage> {
  List<String> listItems = ["第一","第二","第三","第四","第五","第六","第七","第八","第九","第十"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder (
          itemCount: listItems.length,
          itemExtent: 50, // 高度50
          itemBuilder: (context,index) {
            return getListItem(index);
          },
      )
    );
  }

  // 获取列表Cell
  Widget getListItem (int index) {
    String textString = listItems[index];
    return Stack(
      children: [
        Positioned(left: 0,top: 0,right: 0,height: 48,child: Center(child: Text(textString),),),
        Positioned(left: 0,top: 49,right: 0,height: 1,child: Container(
          color: Colors.orange,
        ),),
      ],
    );
  }

}


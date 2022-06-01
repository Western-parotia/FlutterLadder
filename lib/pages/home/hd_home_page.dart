//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 主Widget
class HDHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDHomePageState();
}

// 状态类
class HDHomePageState extends State<HDHomePage> {
  List<String> listItems = ["收藏","黑夜模式","色彩主体","设置","检查更新"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder (
          itemCount: listItems.length,
          itemExtent: 51, // 高度50
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
        const Positioned(left: 20,top: 10,width: 30,height: 30,child: Icon(Icons.favorite,color: Colors.red)
        ),
         Positioned(left: 70,top: 15,width: 80,height: 20,child: Text(textString)
        ),
        Positioned(right: 15,top: 17,width: 16,height: 16,child: Image(width: 16,height: 16,image: AssetImage("images/ic_arrow_right.png"),)
        ),

        // Positioned(left: 0,top: 0,right: 0,height: 48,
        //   child: Center(child: Text(textString),
        //   ),
        // ),
        Positioned(left: 15,top: 50,right: 15,height: 1,child: Container(
          color: Colors.grey,
        ),),
      ],
    );
  }

}


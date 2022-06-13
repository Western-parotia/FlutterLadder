
import 'dart:ffi';

import 'package:flutter/material.dart';

class HDRecommendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDRecommendPageState();
}

class HDRecommendPageState extends State<HDRecommendPage> {
  List titleArray = ["开发环境","测试环境"];
  List dataArray = [["AndroidStudio相关","gradle","官方发布","deep lind","adlb"],["你好啊","张三","李四","阿古拉的丽热巴古力娜扎","Flutter CustomerView","GridView","list","电脑","键盘"]];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: getWrap(),
      body: ListView.builder(itemBuilder: (BuildContext context,int index) {
          return getCustomerGridView(index);
      },
        itemCount: titleArray.length,) ,
    );
  }

  Widget getWrap () {
    return Wrap(
      /**
       * 当direction  为 Axis.horizontal 时主轴为横向交叉轴为纵向， 那么spacing为横向间距，runSpacing为纵向间距
          当direction  为Axis.vertical 时主轴为纵向交叉轴为横向，那么spacing为纵向间距，runSpacing为横向间距
       */
       // clipBehavior: Clip.hardEdge,
        children: getContainer(1),
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
       // alignment:WrapAlignment.start,
       // runAlignment: WrapAlignment.start // 内容或组件在交叉轴的位置
    );
  }

 Widget getGrid(int index) {
    return Container(height: 60,color: Colors.black,);
 }
  Widget getCustomerGridView(int index) {
    List gridData = dataArray[index];
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 10),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(titleArray[index]),
          Padding(padding: EdgeInsets.only(top: 10,bottom: 3), child: Wrap(
        /**
         * 当direction  为 Axis.horizontal 时主轴为横向交叉轴为纵向， 那么spacing为横向间距，runSpacing为纵向间距
            当direction  为Axis.vertical 时主轴为纵向交叉轴为横向，那么spacing为纵向间距，runSpacing为横向间距
         */
          clipBehavior: Clip.hardEdge,
          children: getContainer(index),
          direction: Axis.horizontal,
          spacing: 10,
          runSpacing: 10,
          alignment:WrapAlignment.start,
          runAlignment: WrapAlignment.start // 内容或组件在交叉轴的位置
      ),
          // child: GridView.builder(
          //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //       // 每个item的水平方向最大宽度
          //         maxCrossAxisExtent: 50,
          //         // 水平方向每个item之间间距
          //         mainAxisSpacing: 10.0,
          //         // 垂直方向每个item之间间距
          //         crossAxisSpacing: 10.0,
          //         mainAxisExtent: 30,
          //     ),
          //     shrinkWrap: true,//增加
          //     itemCount: gridData.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       String title = gridData[index];
          //        return Container(decoration: BoxDecoration(
          //            borderRadius: BorderRadius.circular(5),color: Colors.blue),
          //          child:Text(title,style: TextStyle(color: Colors.white)) ,
          //         // height: 25,
          //          //margin: EdgeInsets.only(right: 10),
          //          alignment: Alignment.center,
          //          padding: EdgeInsets.only(left: 8,right: 8),
          //        );
          //     }),

      )],
    )
    );
  }
  
  dynamic getContainer(int index) {
    List<Widget> array = [];
    int currentIndex = 0;
    List<String> listArray = dataArray[index];
    for (var item in listArray) {
      array.add(Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
          color: Colors.blue),
          child:Text(listArray[currentIndex],style: TextStyle(color: Colors.white)) ,
          padding: EdgeInsets.only(left: 4,top: 4,bottom: 4,right: 4),
      ));
      currentIndex ++;
    }
    return array;
  }
  
}
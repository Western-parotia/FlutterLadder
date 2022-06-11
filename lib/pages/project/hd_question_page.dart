
import 'package:flutter/material.dart';

class HDQuestionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDQuestionPageState();
}

class HDQuestionPageState extends State<HDQuestionPage> {

  Widget build(BuildContext context) {
     return  RepaintBoundary(
    // itemBuilder 是一个返回Widget的Function
        child: ListView.separated(
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){

              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                  child: getQuestioinItem(),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Container(
            height: 5,
          ),
          itemCount: 10,
            //cacheExtent:100
        ),
    );
  }

  Widget getQuestioinItem() {
      return Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
              child: Row(
                  children: [
                    Text("2022-06-11"),
                    Expanded(child: Container(),),
                    Container(decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: Colors.blue),
                        child:Text("本站发布",style: TextStyle(color: Colors.white),) ,
                        height: 25,
                        margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.only(left: 8,right: 8),
                      alignment: Alignment.center,
                    ),
                    Container(decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),color: Colors.blue),
                      child:Text("问答",style: TextStyle(color: Colors.white)) ,
                      height: 25,
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 8,right: 8),
                    ),
                  ],
              ),),
            Padding(padding: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
              child: Text("你好啊Flutter,每日一问：如何前置发现VerifyError相关问题"),),
            Padding(padding: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 10),
              child: Row(
                children: [Text("作者：xiyang")],
              ),)
          ],
      );
  }

}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/utils/screen_utils.dart';

import 'hd_arc_view.dart';


class HDLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDLoginPageState();
}
class HDLoginPageState extends State<HDLoginPage> {
  // 头部蓝色背景
  double topBgViewH = 250;
  // 账号密码输入View 高度
  double inputViewH = 250;
  // 登录图标高度
  double loginIconH = 80;
  //double inputViewW = Screen.width(context) - 80;
  // 关闭按钮高度
  double closeIconH = 25;

  // 账号输入控制器
  TextEditingController accountController = TextEditingController()..addListener(() {

  });
  // 密码输入控制器
  TextEditingController passwordController = TextEditingController()..addListener(() {

  });
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: getLoginSubViews(),
    );
  }

  // 账号密码输入框 登录按钮
  Widget getLoginSubViews() {
    double width = Screen.width(context);
    return Stack(
       children: [
         getBackGroundView(),
         // 关闭按钮
         Container(margin: EdgeInsets.only(left: 20,top: 35),
           width: closeIconH,
           height: closeIconH,
           child: InkWell(child: Image.asset("images/hd_white_close.png"),
             onTap:() {
             }),),
         getContentSubViews(),
         /**
         // 关闭图标
         Positioned(left: 20,top: 40,width: 30,height: 30,child: InkWell(child: Image.asset("images/icon_flutter.png"),
             onTap:() {
             })),
         // 登录Ico
         Positioned(left: (width-80.0)/2,top: 80,width: 80,height: 80,child: Image.asset("images/icon_flutter.png")),
         // 间隔
         Positioned(left: 0,top: 160,right: 0,height: 50,
             child: Container(
             )
         ),
         // 账号密码输入View
         Positioned(left:40,right: 40,top: 210,height: 250,child: getInputView())
             */
       ],
    );
  }

  // 视图背景
  Widget getBackGroundView () {
    return Column(
        children: [
           Container(width: Screen.width(context),height: topBgViewH,color: Colors.blue,),
           Padding(child: Container(color: Colors.grey,),padding: EdgeInsets.all(0),)
        ],
    );
  }

  // 登录页面子View
  Widget getContentSubViews () {
    return Column(
       children: [
          Container(margin: EdgeInsets.only(top: 80),width: loginIconH,height: loginIconH,child: Image.asset("images/icon_flutter.png"),),
          Padding(padding: EdgeInsets.only(top: 40),child: getInputView(),),
          Padding(padding: EdgeInsets.only(top: 30),child: getThirdLoginTipView()),
          Padding(padding: EdgeInsets.only(top: 20,left: 0,right: 0),child: getThirdLoginTypeView(),)
       ],
    );
  }

  // 账号密码输入View
  Widget getInputView () {
    return Container(
      height: inputViewH,
      margin: EdgeInsets.only(left: 30,right: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        // blurRadius: 阴影模糊程度  spreadRadius: 1.0 //阴影扩散程度
        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(1.0, 1.0), blurRadius: 15, spreadRadius: 3.0) ],
      ),
      //color: Colors.white,
      padding: EdgeInsets.only(left: 10,right: 10,top: 15),
      child: Column (
         children: [
            Container(
              height: 50,
              child: getAccountTextField(),
            ),
           Container(
             height: 50,
             child: getPasswordTextField(),
           ),

           Container(height: 40,margin: EdgeInsets.only(left: 10,top: 40,right: 10,bottom: 15),child: Center(
             child:ElevatedButton(child: const Text("登录",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
                 minimumSize: const Size(double.infinity, 40),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
             ),onPressed:() {
               // 登录按钮点击
             },)),),
           RichText(text: TextSpan(
             text: "还没账号？",
             style: TextStyle(fontSize: 14,color: Colors.black),
             children: [
               TextSpan(
                   text: "去注册",
                   style: TextStyle(fontSize: 14,color: Colors.blue),
                   recognizer: TapGestureRecognizer()..onTap = () {
                     print('点击了去注册');
                   },)
             ]
           ))
         ],
      ),
    );
  }

  // 账号输入框
  Widget getAccountTextField() {
    return TextFormField(
      controller: accountController,
      decoration: const InputDecoration(
          hintText: '用户名',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.person,color: Colors.blue)),
    );
  }

  // 密码输入框
  Widget getPasswordTextField() {
    return TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(
          hintText: '密码',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.lock,color: Colors.blue),
          suffixIcon: Icon(Icons.lock)),
    );
  }

  // 第三方登录View
  Widget getThirdLoginView () {
    return Column(
      children: [
        getThirdLoginTipView(),getThirdLoginTypeView()
      ],
    );
  }
  // 第三方登录提示View
  Widget getThirdLoginTipView () {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 60,height: 1,color: Colors.grey),
          Padding(padding: EdgeInsets.only(left: 30,right: 30),child: Text("第三方登录",style: TextStyle(color: Colors.grey),),),
          Container(width: 60,height: 1,color: Colors.grey)
        ],
      );
  }

  // 第三方登录方式View
  Widget getThirdLoginTypeView () {
    double ratio = Screen.width(context)/2/5;
    //print("$ratio");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(child: Image.asset("images/icon_flutter.png",width: 50,height: 50,),
            onTap:() {
            }),
        InkWell(child: Image.asset("images/icon_flutter.png",width: 50,height: 50),
            onTap:() {
            })
      ],
    );
  }

}
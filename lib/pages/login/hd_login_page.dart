//
//import 'dart:html';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/net/mj_http_tool.dart';
import 'package:wanandroid_app/utils/screen_utils.dart';
import 'package:wanandroid_app/net/api.dart';           // http请求
import 'hd_arc_view.dart';
import 'package:fluttertoast/fluttertoast.dart';        // 登录提示
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_app/pages/login/hd_register_page.dart';


class HDLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDLoginPageState();
}
class HDLoginPageState extends State<HDLoginPage> {
  // 头部蓝色背景
  double topBgViewH = 260;
  // 账号密码输入View 高度
  //double inputViewH = 250;
  // 登录图标高度
  double loginIconH = 80;
  // 关闭按钮高度
  double closeIconH = 25;

  // 账号输入控制器
  TextEditingController accountController = TextEditingController()..addListener(() {

  });
  // 密码输入控制器
  TextEditingController passwordController = TextEditingController()..addListener(() {

  });
  // 定义GlobalKey 服务于从子Widget获取父Widget的 state,然后调用state中的一些方法
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    accountController.dispose();
    passwordController.dispose();
  }
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
                Navigator.pop(context);
             }),),
         getContentSubViews(),
       ],
    );
  }

  // 视图背景
  Widget getBackGroundView () {
    double paintX = Screen.width(context)/2;
    double paintY = topBgViewH/2 + 100;
    return Column(
        children: [
           ClipPath(clipper: BottomClipper(),child:Container(color: Colors.blue,width: Screen.width(context),height:topBgViewH,)),
           Container(color: Colors.grey)
        ],
    );
  }

  // 登录页面子View
  Widget getContentSubViews () {
    return Column(
       children: [
          Container(margin: EdgeInsets.only(top: 120),width: loginIconH,height: loginIconH,child: Image.asset("images/icon_flutter.png"),),
          Padding(padding: EdgeInsets.only(top: 30),child: getInputView(),),
          Padding(padding: EdgeInsets.only(top: 30),child: getThirdLoginTipView()),
          Padding(padding: EdgeInsets.only(top: 20,left: 0,right: 0),child: getThirdLoginTypeView(),)
       ],
    );
  }

  // 账号密码输入View
  Widget getInputView () {
    return Container(
      //height: inputViewH,
      margin: EdgeInsets.only(left: 30,right: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        // blurRadius: 阴影模糊程度  spreadRadius: 1.0 //阴影扩散程度
        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(1.0, 1.0), blurRadius: 15, spreadRadius: 3.0) ],
      ),
      //color: Colors.white,
      padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 20),
      child:Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column (
          children: [
            Container(
              child: getAccountTextField(),
            ),
            Container(
              child: getPasswordTextField(),
            ),
            Container(height: 40,margin: EdgeInsets.only(left: 10,top: 40,right: 10,bottom: 15),child: Center(
                child:ElevatedButton(child: const Text("登录",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),onPressed:() {
                  // 登录按钮点击
                  if ((_formKey.currentState as FormState).validate()) {
                      print("验证成功");
                      String username = accountController.value.text;
                      String password = passwordController.value.text;
                      httpRequestLogin(); // 开始登录
                      if (username == "hello" && password == "123456") {
                        print("登陆成功");
                      } else {
                        print("登陆失败");
                      }
                  } else {
                    print("验证失败");
                  }
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return HDRegisterPage();
                      }));
                      // Navigator.push(context, route)
                    },)
                ]
            ))
          ],
        ),
      ),

    );
  }

  void httpRequestLogin() {
    Map<String, String> params = {
      "username": accountController.text,
      "password": passwordController.text
    };
    MJHttpTool().postFormRequestData(Api.login, params, (value) async {
      Map<String, dynamic> jsonMap = json.decode(value);
      int errorCode = jsonMap["errorCode"];
      String errorMsg = jsonMap["errorMsg"];
      if (errorCode == 0) {
        print("登录成功");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userAccount", accountController.text);
        prefs.setString("userPassword", passwordController.text);
        Fluttertoast.showToast(msg: "登录成功！", gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: errorMsg, gravity: ToastGravity.CENTER);
      }
    }, (value) => {

    }, () {

    });
  }
  // 账号输入框
  Widget getAccountTextField() {
    return TextFormField(
      //autofocus: true,
      controller: accountController,
      validator: (value) {
        // trim 去除字符串左右两边的空格
        if (value != null && value.trim().length > 6) {
          print("校验通过");
          return null; //代表校验通过
        } else {
          print("用户名不能少于6位");
          return "用户名不能少于6位";
        }
      },
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
      validator: (value) {
        // trim 去除字符串左右两边的空格
        if (value != null && value.trim().length > 6) {
          print("校验通过");
          return null; //代表校验通过
        } else {
          print("用户名不能少于6位");
          return "密码不能少于6位";
        }
      },
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
      // child: Image.asset("images/icon_flutter.png",width: 50,height: 50,)
      // Image.asset("images/icon_flutter.png",width: 50,height: 50)
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(child:Icon(Icons.wechat,size: 50,color: Colors.blue,) ,
            onTap:() {
            }),
        InkWell(child:Icon(Icons.share,size: 50,color: Colors.blue,) ,
            onTap:() {
            })
      ],
    );
  }

}
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // (1)根据坐标点绘制,size包含了子组件宽高
    // (2)若不是被贝塞尔曲线，依次直线相连lineTo设置的坐标路径剪裁
    // (3)若使用了贝塞尔曲线，则贝塞尔曲线的首尾点的前后的点先连也是贝塞尔曲线
    // 贝塞尔绘制弧线
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    // 贝塞尔曲线的两个坐标，根据高低通过弧线相连
    var firstPoint = Offset(size.width / 2, size.height + 10);
    var endPoint = Offset(size.width, size.height - 50);
    // 绘制贝塞尔曲线
    path.quadraticBezierTo(
        firstPoint.dx, firstPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    /*
    // 贝塞尔绘制波浪线
    path.lineTo(0,0);
    path.lineTo(0,size.height-40);
    // 波浪线需要四个贝塞尔坐标，分别在1/4、1/2.25，3/4，1处设置，会根据高低弧线相连
    var firstPoint=Offset(size.width/4,size.height);
    var secondPoint=Offset(size.width/2.25,size.height-30);
    path.quadraticBezierTo(firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy);
    var thirdPoint = Offset(size.width / 4 * 3, size.height - 90);
    var fourthPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
        thirdPoint.dx, thirdPoint.dy, fourthPoint.dx, fourthPoint.dy);
    path.lineTo(size.width, 0);
    * */
    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldDelegate) => true;
}


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/net/api.dart';
import 'package:wanandroid_app/net/mj_http_tool.dart';
import 'package:fluttertoast/fluttertoast.dart';        // 登录提示
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_app/pages/mine/hd_mine_page.dart';
class HDRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HDRegisterPageState();
}
class HDRegisterPageState extends State<HDRegisterPage> {
  // 定义GlobalKey 服务于从子Widget获取父Widget的 state,然后调用state中的一些方法
  final GlobalKey _formKey = GlobalKey<FormState>();
  // 账号输入控制器
  TextEditingController accountController = TextEditingController()..addListener(() {

  });
  // 密码输入控制器
  TextEditingController passwordController = TextEditingController()..addListener(() {

  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册"),
          backgroundColor:Colors.blue
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15,left: 15,right: 15),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              getAccountTextField(),
              getPasswordTextField(),
              SizedBox(height: 30,),
              Container(
               // alignment: Alignment.,
                padding: EdgeInsets.only(left: 15,right: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40)),
                  child: Text("注册",style: TextStyle(fontSize: 18),),
                  onPressed: (){
                    // 验证通过
                     if ((_formKey.currentState as FormState).validate()) {
                          httpRequestRegister();
                     }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void httpRequestRegister() {
     Map<String,String> param = {
       "username": accountController.text,
       "password": passwordController.text,
       "repassword": passwordController.text
     };
     MJHttpTool().postFormRequestData(Api.register, param, (value) async {
        Map<String,dynamic> dict = json.decode(value);
        int errorCode = dict["errorCode"];
        String errorMsg = dict["errorMsg"];
        if (errorCode == 0) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userAccount", accountController.text);
          prefs.setString("userPassword", passwordController.text);
          Fluttertoast.showToast(msg: "注册成功",gravity: ToastGravity.CENTER);
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         builder: (context) => Tabs(index: 2)), (route) => route == null);
          Navigator.pop(context);
        }

     }, (value) {

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
}
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isLogin = false;
  var userName = "";

  void loginIn(String userName) {
    this.userName = userName;
    isLogin = true;
  }

  void loginOut() {
    isLogin = false;
    userName = "";
  }
}

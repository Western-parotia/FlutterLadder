import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isLogin = false;
  var userName = "";
  var password = "";

  void loginIn(String userName, String password) {
    this.userName = userName;
    this.password = password;
    isLogin = true;
  }
}

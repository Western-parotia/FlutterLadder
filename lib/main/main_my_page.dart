import 'package:flutter/material.dart';
import 'package:wanandroid_app/ext/string_ext.dart';
import 'package:wanandroid_app/login/login_page.dart';

class MainMyPage extends StatefulWidget {
  const MainMyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainMyState();
  }
}

class _MainMyState extends State<MainMyPage> {
  var _lightOpened = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.android_rounded,
                    color: Colors.blueGrey,
                    size: 50,
                  ),
                ),
                InkWell(
                  child: const Text(
                    "点我登录",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                ),
              ],
            ),
          ),
          _settingWidget(Icons.favorite_border, "收藏", Icons.chevron_right, () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("111")));
          }),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.brightness_5,
                  color: Colors.blue,
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        "黑夜模式",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Switch(
                    value: _lightOpened,
                    onChanged: (isOpen) {
                      setState(() {
                        _lightOpened = isOpen;
                      });
                    })
              ],
            ),
          ),
          _settingWidget(Icons.palette, "色彩主题", Icons.arrow_drop_down_rounded,
              () {
            "2222".toast(context);
          }),
          _settingWidget(Icons.settings, "设置", Icons.chevron_right, () {
            "333".toast(context);
          }),
          _settingWidget(Icons.system_update, "检测更新", Icons.chevron_right, () {
            "444444".toast(context);
          })
        ],
      ),
    );
  }

  Widget _settingWidget(IconData leftIcon, String text, IconData rightIcon,
      GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(
              leftIcon,
              color: Colors.blue,
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 20),
                  )),
            ),
            Icon(
              rightIcon,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

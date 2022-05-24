import 'package:flutter/cupertino.dart';

class WechatAccountPage extends StatefulWidget {
  const WechatAccountPage({Key? key}) : super(key: key);

  @override
  State<WechatAccountPage> createState() => _WechatAccountPageState();
}

class _WechatAccountPageState extends State<WechatAccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('公众号'),
    );
  }
}

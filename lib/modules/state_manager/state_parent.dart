import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/ext/ext.dart';

class TapboxA extends StatefulWidget {
  const TapboxA({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TapboxAState();
  }
}

class TapboxAState extends State<TapboxA> {
  final tag = "TapboxAState";
  bool _active = false;

  void _onTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    "build before super".logI(tag);
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        color: _active ? Colors.greenAccent : Colors.grey,
        child: Center(
          child: Text(
            _active ? "Click to Active" : "Click to Inactive",
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }

  ///生命周期函数监听----------------------------------------------------------
  @override
  void initState() {
    "initState before super".logI(tag);
    super.initState();
    "initState after super".logI(tag);
  }

  @override
  void didChangeDependencies() {
    "didChangeDependencies before super".logI(tag);
    super.didChangeDependencies();
    "didChangeDependencies after super".logI(tag);
  }

  @override
  void didUpdateWidget(covariant TapboxA oldWidget) {
    "didUpdateWidget before super".logI(tag);
    super.didUpdateWidget(oldWidget);
    "didUpdateWidget after super".logI(tag);
  }

  @override
  void activate() {
    "didUpdateWidget before super".logI(tag);
    super.activate();
    "activate before super".logI(tag);
  }

  @override
  void deactivate() {
    "didUpdateWidget before super".logI(tag);
    super.deactivate();
    "deactivate before super".logI(tag);
  }

  @override
  void dispose() {
    "dispose before super".logI(tag);
    super.dispose();
    "dispose before super".logI(tag);
  }

  @override
  void setState(VoidCallback fn) {
    "setState before super".logI(tag);
    super.setState(fn);
    "setState before super".logI(tag);
  }

  @override
  void reassemble() {
    "reassemble before super".logI(tag);
    super.reassemble();
    "reassemble before super".logI(tag);
  }
}

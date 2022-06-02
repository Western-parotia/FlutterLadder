import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/ext/ext.dart';

class ParentWidget extends StatefulWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _tapBActive = false;

  void _onTapBClick(bool newValue) {
    setState(() {
      _tapBActive = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TapboxB(active: _tapBActive, onClick: _onTapBClick),
    );
  }
}

class TapboxB extends StatelessWidget {
  final tag = "TapboxB";

  final ValueChanged<bool> onClick;
  bool active = false;

  TapboxB({Key? key, this.active = false, required this.onClick})
      : super(key: key);

  void _onTap() {
    onClick(!active);
  }

  @override
  Widget build(BuildContext context) {
    "build ".logI(tag);
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 300,
        height: 500,
        child: Center(
          child: Text(
            active ? "Click to Inactive" : "Click to Active",
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
            color: active ? Colors.yellow[900] : Colors.grey[400]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

extension StringExt on Object? {
  void toast(BuildContext context) {
    var st = this?.toString();
    if (st == null || st.isEmpty) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(st),
      duration: const Duration(seconds: 2),
    ));
  }

  void println({Object? title}) {
    var t = title?.toString();
    var content = this?.toString();
    var b = StringBuffer();

    if (t != null && t.isNotEmpty) {
      b.write(t);
      b.write("\n");
    }
    if (content != null && content.isNotEmpty) {
      b.write(content);
      b.write("\n");
    }
    if (b.isEmpty) {
      b.write("empty print\n");
    }

    print(b.toString());
  }
}

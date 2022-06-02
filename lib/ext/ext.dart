import 'package:flutter/material.dart';
import 'package:wanandroid_app/utils/log_utils.dart';

extension StringExt on String {
  /// 通过在相邻的字符中插入不可见的幽灵字符，避免系统识别为完整单词或连续数字而断句
  String joinGhostCharacter() {
    return Characters(this).join('\u{200B}');
  }

  void logI(String? tag) {
    Log.i("$tag:-:$this");
  }
}

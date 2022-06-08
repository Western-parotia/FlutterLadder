import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_app/utils/colors.dart';

class HDArcView extends CustomPainter {
   const HDArcView({
      required this.paintX,
      required this.paintY,
      required this.colors,
   }) : super();
   final Color colors;
   final double paintX;
   final double paintY;
   @override
   void paint(Canvas canvas, Size size) {
      var hdPaint = Paint();
      hdPaint.isAntiAlias = true;          // 是否启动抗锯齿
      hdPaint.strokeWidth = 0.0;           // 画笔的宽度
      hdPaint.strokeCap = StrokeCap.round; // 画笔笔触类型
      hdPaint.color = colors;              // 画笔颜色
      hdPaint.invertColors = false;
      // fromCircle: 画一个正方形,介绍链接：https://zhuanlan.zhihu.com/p/376329260
      Rect rect = Rect.fromCenter(center: Offset(paintX,paintY),width: size.width,height: size.height);
      // drawArc：绘制圆弧
      Rect bgRect = Rect.fromCenter(center: Offset(paintX,paintY),width: size.width,height: size.height);
      //canvas.drawRect(rect,hdPaint);
      canvas.drawArc(rect,0.0, 180*(pi/180), false, hdPaint);
   }
   @override
   bool shouldRepaint(CustomPainter oldDelegate) => true;
}
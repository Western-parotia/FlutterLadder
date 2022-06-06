import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:wanandroid_app/utils/colors.dart';

class HDArcView extends CustomPainter {

   @override
   void paint(Canvas canvas, Size size) {
      var hdPaint = Paint();
      hdPaint.isAntiAlias=true;
      hdPaint.strokeWidth=0.0;
      hdPaint.color = Color(0xFF4688FA);
      hdPaint.invertColors = false;
      Rect rect = Rect.fromCircle(center: Offset(size.width/2,size.height/2),radius: 100.0);
      canvas.drawArc(rect, 0.0, 2*pi/4, false, hdPaint);
   }
   @override
   bool shouldRepaint(CustomPainter oldDelegate) => true;
}
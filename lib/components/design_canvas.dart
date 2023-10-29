import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DesignCanvas extends CustomPainter {
  ui.Image? bgImage;
  int imageCount = 0;
  int selectedIndex = 0;
  double screenW = 0;
  double screenH = 0;
  double offsetX = 0;
  double offsetY = 0;
  DesignCanvas(this.bgImage, this.imageCount, this.selectedIndex, this.offsetX, this.offsetY, this.screenW, this.screenH);

  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);
    var offsetBG = Offset(size.width / 2 + offsetX, size.height / 2 + offsetY);

    var aspect = size.width / 110.0 * 0.6;
    W = 110.0 * aspect;
    H = 200.0 * aspect;

    print(offsetBG);
    drawBGImage(canvas, offsetBG);
    //drawImage(canvas, offset);
    //drawColor(canvas);
    drawFill(canvas, offset, size);
    drawFrame(canvas, offset);
    drawDots(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawColor(Canvas canvas) {
    canvas.drawColor(const Color.fromARGB(150, 255, 0, 0), BlendMode.dstIn);
  }

  void drawFill(Canvas canvas, Offset offset, Size size) {
    var rect = Rect.fromCenter(center: offset, width: W, height: H);
    var border = Paint()
      ..color = Color.fromARGB(167, 0, 0, 0)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;

    //canvas.drawRect(rect, border);
    var rrect = RRect.fromRectXY(rect, 70, 70);

    var rectOver = Rect.fromCenter(center: offset, width: size.width, height: size.height);
    var rrectOver = RRect.fromRectXY(rectOver, 0, 0);

    canvas.drawDRRect(rrectOver, rrect, border);
  }

  var W = 110.0 * 1;
  var H = 200.0 * 1;
  void drawFrame(Canvas canvas, Offset offset) {
    var rect = Rect.fromCenter(center: offset, width: W, height: H);
    print(rect);
    var border = Paint()
      ..color = Colors.black
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    //canvas.drawRect(rect, border);
    var rrect = RRect.fromRectXY(rect, 70, 70);
    canvas.drawRRect(rrect, border);
  }

  void drawImage(Canvas canvas, Offset offset) {
    if (this.bgImage != null) {
      var rect = Rect.fromCenter(center: offset, width: W, height: H);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(bgImage!, rect, canvas, Paint(), BoxFit.cover);
    }
  }

  void drawBGImage(Canvas canvas, Offset offset) {
    if (this.bgImage != null) {
      var rect = Rect.fromCenter(center: offset, width: screenW, height: screenH);
      print("DRAWGB");
      print(rect);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(bgImage!, rect, canvas, Paint(), BoxFit.contain);
    }
  }

  void drawDots(Canvas canvas, Offset offset) {
    var pOff = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = const Color.fromARGB(255, 223, 8, 8);
    var pOn = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromARGB(255, 212, 11, 11);

    var radius = 10.0;
    var k = 2 * radius + 5.0;
    var c = Offset(-k * (imageCount - 1.0) / 2.0, W / 2 + 20);
    for (var i = 0; i < imageCount; i++) {
      if (i == this.selectedIndex % imageCount) {
        canvas.drawCircle(c + offset, radius, pOn);
      } else {
        canvas.drawCircle(c + offset, radius, pOff);
      }
      c += Offset(k, 0);
    }
  }

  void paintImage(
      ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect =
        Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
        Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
  }
}
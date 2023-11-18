import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
//import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class PreviewCanvas extends CustomPainter {
  ui.Image? bgImage;
  ui.Image? phoneImage;
  ui.Image? phoneOverImage;
  ui.Image? shadowsImage;
  ui.Image? shadowsImage_1;
  int imageCount = 0;
  int selectedIndex = 0;
  double screenW = 0;
  double screenH = 0;
  double offsetX = 0;
  double offsetY = 0;
  double zoom = 0;
  double overZoom = 1.11;
  PreviewCanvas(this.bgImage, this.phoneImage, this.shadowsImage, this.shadowsImage_1, this.phoneOverImage, this.imageCount, this.selectedIndex, this.offsetX, this.offsetY, this.screenW, this.screenH, this.zoom, this.overZoom);

  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);
    var offsetBG = Offset(size.width / 2 + offsetX, size.height / 2 + offsetY);

    var aspect = size.width / 110.0 * 0.6;
    W = 110.0 * aspect;
    H = 200.0 * aspect;

    drawBGImage(canvas, offsetBG);
    //drawImage(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  var W = 110.0 * 1;
  var H = 200.0 * 1;

  void drawImage(Canvas canvas, Offset offset) {
    if (this.bgImage != null) {
      var rect = Rect.fromCenter(center: offset, width: W, height: H);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(bgImage!, rect, canvas, Paint(), BoxFit.cover);
    }
  }

  void drawBGImage(Canvas canvas, Offset offset) {
    if (this.shadowsImage_1 != null) {
      //var rect = Rect.fromCenter(center: offset, width: screenW, height: screenH);
      var rect = Rect.fromLTRB(0,0,screenW, screenH);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(shadowsImage_1!, rect, canvas, Paint(), BoxFit.contain);
    }
    if (this.bgImage != null) {
      var rect = Rect.fromCenter(center: offset, width: screenW * overZoom, height: screenH * overZoom);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(bgImage!, rect, canvas, Paint(), BoxFit.contain);
    }
    if (this.phoneOverImage != null) {
      //var rect = Rect.fromCenter(center: offset, width: screenW * overZoom, height: screenH * overZoom);
      var offsetOver = Offset(screenW / 2, screenH / 2);
      var rect = Rect.fromCenter(center: offsetOver, width: screenW * overZoom, height: screenH * overZoom);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(phoneOverImage!, rect, canvas, Paint(), BoxFit.contain);
    }
    if (this.phoneImage != null) {
      //var rect = Rect.fromCenter(center: offset, width: screenW, height: screenH);
      var rect = Rect.fromLTRB(0,0,screenW, screenH);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(phoneImage!, rect, canvas, Paint(), BoxFit.contain);
      canvas.clipRect(rect, doAntiAlias: false);
    }
    if (this.shadowsImage != null) {
      //var rect = Rect.fromCenter(center: offset, width: screenW, height: screenH);
      var rect = Rect.fromLTRB(0,0,screenW, screenH);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(shadowsImage!, rect, canvas, Paint(), BoxFit.contain);
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
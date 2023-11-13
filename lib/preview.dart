import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter_application_1/components/preview_canvas.dart';
// import 'components/design_canvas.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  var images = List<ui.Image>.empty();
  ui.Image? selectedImage;
  ui.Image? phoneImage;
  ui.Image? phoneOverImage;
  ui.Image? shadowsImage;
  ui.Image? shadowsImage_1;
  int selectedIndex = 0;

  double offsetX = 0;
  double offsetY = 0;

  // double zoomOffsetX = 0;
  // double zoomOffsetY = 0;

  double zoom = 1;
  double initZoom = 1;

  double zoomX = 1;
  double zoomY = 1;

  //late DesignCanvas canvas;
  
  @override
  void initState() {
    super.initState();
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        child: Container(height: MediaQuery.of(context).size.height / 2 - 50,
      width: MediaQuery.of(context).size.width / 2 - 50),
        painter: PreviewCanvas(selectedImage, phoneImage, shadowsImage, shadowsImage_1, phoneOverImage, images.length, selectedIndex, offsetX, offsetY, MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2, zoom),
      );
  }

  void loadImages() {
    rootBundle.load("assets/img4.jpg").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          selectedImage = img;

          var offsetBG = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
          var rect = Rect.fromCenter(center: offsetBG, width: MediaQuery.of(context).size.width * zoom, height: MediaQuery.of(context).size.height * zoom);
          
          final Size imageSize = Size(selectedImage!.width.toDouble(), selectedImage!.height.toDouble());
          final FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, rect.size);
          final Rect outputSubrect =
                  Alignment.center.inscribe(sizes.destination, rect);
          
          var offset = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
          var aspect = MediaQuery.of(context).size.width / 110.0 * 0.6;
          var W = 110.0 * aspect;
          var H = 200.0 * aspect;
          var borderRect = Rect.fromCenter(center: offset, width: W, height: H);

          zoomY = (borderRect.bottom - borderRect.top) / (outputSubrect.bottom - outputSubrect.top);
          zoomX = (borderRect.right - borderRect.left) / (outputSubrect.right - outputSubrect.left);
          zoom = zoomX > zoomY ? zoomX : zoomY;
          initZoom = zoom;
        });
      });
    });
    rootBundle.load("assets/Iphone_11_Pro_over.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          phoneOverImage = img;
        });
      });
    });
    rootBundle.load("assets/Iphone_11_Pro_transparent_1.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          phoneImage = img;
        });
      });
    });
    rootBundle.load("assets/Iphone_11_Pro_shadows.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          shadowsImage = img;
        });
      });
    });
    rootBundle.load("assets/Iphone_11_Pro_shadows_1.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          shadowsImage_1 = img;
        });
      });
    });
  }
}
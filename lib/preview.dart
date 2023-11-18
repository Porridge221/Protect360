import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter_application_1/components/preview_canvas.dart';
// import 'components/design_canvas.dart';

class Preview extends StatefulWidget {
  final String phoneType;
  double offsetX = 0;
  double offsetY = 0;
  double zoom = 1;
  Preview({super.key, required this.phoneType, required this.offsetX, required this.offsetY, required this.zoom});

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

  // double offsetX = 0;
  // double offsetY = 0;

  // double zoomOffsetX = 0;
  // double zoomOffsetY = 0;

  // double zoom = 1;
  double initZoom = 1;

  double zoomX = 1;
  double zoomY = 1;

  //late DesignCanvas canvas;

  double overZoom = 1.11;
  
  @override
  void initState() {
    super.initState();
    switch (widget.phoneType) {
      case 'Galaxy_M52':
        overZoom = 1.11;
        break;
      case 'Iphone 11 Pro':
        overZoom = 1.295;
        break;
      case 'Huawei_P50_Pro':
        overZoom = 1.14;
        break;
      case 'iPhone_14_Pro_Max':
        overZoom = 1.123;
        break;
      default:
    }
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        child: Container(height: MediaQuery.of(context).size.height / 2 - 50,
      width: MediaQuery.of(context).size.width / 2 - 50),
        painter: PreviewCanvas(selectedImage, phoneImage, shadowsImage, shadowsImage_1, phoneOverImage, images.length, selectedIndex, widget.offsetX, widget.offsetY, MediaQuery.of(context).size.width / 2 - 50, MediaQuery.of(context).size.height / 2 - 50, widget.zoom, overZoom),
      );
  }

  void loadImages() {
    rootBundle.load("assets/img1.jpg").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          selectedImage = img;

          // var offsetBG = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
          // var rect = Rect.fromCenter(center: offsetBG, width: MediaQuery.of(context).size.width * zoom, height: MediaQuery.of(context).size.height * zoom);
          
          // final Size imageSize = Size(selectedImage!.width.toDouble(), selectedImage!.height.toDouble());
          // final FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, rect.size);
          // final Rect outputSubrect =
          //         Alignment.center.inscribe(sizes.destination, rect);
          
          // var offset = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
          // var aspect = MediaQuery.of(context).size.width / 110.0 * 0.6;
          // var W = 110.0 * aspect;
          // var H = 200.0 * aspect;
          // var borderRect = Rect.fromCenter(center: offset, width: W, height: H);

          // zoomY = (borderRect.bottom - borderRect.top) / (outputSubrect.bottom - outputSubrect.top);
          // zoomX = (borderRect.right - borderRect.left) / (outputSubrect.right - outputSubrect.left);
          // zoom = zoomX > zoomY ? zoomX : zoomY;
          // initZoom = zoom;
        });
      });
    });
    rootBundle.load("assets/${widget.phoneType}/phone_over.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          phoneOverImage = img;
        });
      });
    });
    rootBundle.load("assets/${widget.phoneType}/phone_transparent.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          phoneImage = img;
        });
      });
    });
    rootBundle.load("assets/${widget.phoneType}/phone_effect.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          shadowsImage = img;
        });
      });
    });
    rootBundle.load("assets/${widget.phoneType}/phone_shadows.png").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          shadowsImage_1 = img;
        });
      });
    });
  }
}
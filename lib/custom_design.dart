import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'components/design_canvas.dart';

class CustomDesign extends StatefulWidget {
  const CustomDesign({super.key});

  @override
  _CustomDesignState createState() => _CustomDesignState();
}

class _CustomDesignState extends State<CustomDesign> {
  var images = List<ui.Image>.empty();
  ui.Image? selectedImage;
  int selectedIndex = 0;

  double offsetX = 0;
  double offsetY = 0;

  double zoom = 1;
  //late DesignCanvas canvas;
  
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width
    //canvas = DesignCanvas(selectedImage, images.length, selectedIndex, offsetX, offsetY, MediaQueryData.fromView(WidgetsBinding.instance.window).size.width * zoom, MediaQueryData.fromView(WidgetsBinding.instance.window).size.height * zoom);
    //canvas = DesignCanvas(selectedImage, images.length, selectedIndex, offsetX, offsetY, MediaQuery.of(context).size.width * zoom, MediaQuery.of(context).size.height * zoom);

    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            var offsetBG = Offset(MediaQuery.of(context).size.width / 2 + offsetX + details.delta.dx, MediaQuery.of(context).size.height / 2 + offsetY + details.delta.dy);
            var rect = Rect.fromCenter(center: offsetBG, width: MediaQuery.of(context).size.width * zoom, height: MediaQuery.of(context).size.height * zoom);
            
            final Size imageSize = Size(selectedImage!.width.toDouble(), selectedImage!.height.toDouble());
            final FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, rect.size);
            final Rect outputSubrect =
                    Alignment.center.inscribe(sizes.destination, rect);
            
            print(outputSubrect);
            var offset = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
            var aspect = MediaQuery.of(context).size.width / 110.0 * 0.6;
            var W = 110.0 * aspect;
            var H = 200.0 * aspect;
            var borderRect = Rect.fromCenter(center: offset, width: W, height: H);

            //zoom = (borderRect.bottom - borderRect.top) / (outputSubrect.bottom - outputSubrect.top);

            if (outputSubrect.left < borderRect.left  && outputSubrect.right > borderRect.right)
              offsetX += details.delta.dx;
            if (outputSubrect.top < borderRect.top  && outputSubrect.bottom > borderRect.bottom)
              offsetY += details.delta.dy;
          });
          print(offsetX);
          print(offsetY);
        },
        child: CustomPaint(
          child: Container(),
          painter: DesignCanvas(selectedImage, images.length, selectedIndex, offsetX, offsetY, MediaQuery.of(context).size.width * zoom, MediaQuery.of(context).size.height * zoom),
        ),
      ),
    );
  }

  void loadImages() {
    rootBundle.load("assets/img2.jpg").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          selectedImage = img;

          var offsetBG = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
            var rect = Rect.fromCenter(center: offsetBG, width: MediaQuery.of(context).size.width * zoom, height: MediaQuery.of(context).size.height * zoom);
            
            final Size imageSize = Size(selectedImage!.width.toDouble(), selectedImage!.height.toDouble());
            final FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, rect.size);
            final Rect outputSubrect =
                    Alignment.center.inscribe(sizes.destination, rect);
            
            print(outputSubrect);
            var offset = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
            var aspect = MediaQuery.of(context).size.width / 110.0 * 0.6;
            var W = 110.0 * aspect;
            var H = 200.0 * aspect;
            var borderRect = Rect.fromCenter(center: offset, width: W, height: H);

            var zoomY = (borderRect.bottom - borderRect.top) / (outputSubrect.bottom - outputSubrect.top);
            var zoomX = (borderRect.right - borderRect.left) / (outputSubrect.right - outputSubrect.left);
            zoom = zoomX > zoomY ? zoomX : zoomY;
        });
      });
    });
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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

  double zoomOffsetX = 0;
  double zoomOffsetY = 0;

  double zoom = 1;
  double initZoom = 1;

  double zoomX = 1;
  double zoomY = 1;

  double scale = 1.0;
  //late DesignCanvas canvas;
  
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width
    //canvas = DesignCanvas(selectedImage, images.length, selectedIndex, offsetX, offsetY, MediaQueryData.fromView(WidgetsBinding.instance.window).size.width * zoom, MediaQueryData.fromView(WidgetsBinding.instance.window).size.height * zoom);
    //canvas = DesignCanvas(selectedImage, images.length, selectedIndex, offsetX, offsetY, MediaQuery.of(context).size.width * zoom, MediaQuery.of(context).size.height * zoom);
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas can = Canvas(recorder);
    loadImages();
    //saveImage(can, recorder);
  }

  Future saveImage(Canvas canvas, ui.PictureRecorder recorder) async {
    //var rect = Rect.fromCenter(center: offset, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height);
    // ui.PictureRecorder recorder = ui.PictureRecorder();
    // Canvas can = Canvas(recorder);
    //drawBGImage(can, offset);
    ui.Image img = await recorder.endRecording().toImage(600, 600);
    Directory dir = (await getDownloadsDirectory())!;
    var file = File('${dir.path}/image1.png');
    //await file.writeAsString(img.toString());
    var res = await file.writeAsBytes((await img.toByteData(format: ui.ImageByteFormat.rawRgba))!.buffer.asInt8List(), flush: true);
    //file.openWrite().add((await img.toByteData())!.buffer.asInt8List());
    //print((await img.toByteData())!.lengthInBytes);
    //final params = SaveFileDialogParams(sourceFilePath: file.path);
    //final finalPath = await FlutterFileDialog.saveFile(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // onPanUpdate: (details) {
        //   setState(() {
        //     var offsetBG = Offset(MediaQuery.of(context).size.width / 2 + offsetX + details.delta.dx, MediaQuery.of(context).size.height / 2 + offsetY + details.delta.dy);
        //     var rect = Rect.fromCenter(center: offsetBG, width: MediaQuery.of(context).size.width * zoom, height: MediaQuery.of(context).size.height * zoom);
            
        //     final Size imageSize = Size(selectedImage!.width.toDouble(), selectedImage!.height.toDouble());
        //     final FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, rect.size);
        //     final Rect outputSubrect =
        //             Alignment.center.inscribe(sizes.destination, rect);
            
        //     print(outputSubrect);
        //     var offset = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
        //     var aspect = MediaQuery.of(context).size.width / 110.0 * 0.6;
        //     var W = 110.0 * aspect;
        //     var H = 200.0 * aspect;
        //     var borderRect = Rect.fromCenter(center: offset, width: W, height: H);
            
        //     //zoom = (borderRect.bottom - borderRect.top) / (outputSubrect.bottom - outputSubrect.top);

        //     if (outputSubrect.left < borderRect.left  && outputSubrect.right > borderRect.right)
        //       offsetX += details.delta.dx;
        //     if (outputSubrect.top < borderRect.top  && outputSubrect.bottom > borderRect.bottom)
        //       offsetY += details.delta.dy;
        //   });
        //   print(offsetX);
        //   print(offsetY);
        // },
        onScaleUpdate: (details) {
          // print(offsetX);
          print(offsetY);
          print(zoom);
          if (details.pointerCount == 1) {
            var offsetBG = Offset(MediaQuery.of(context).size.width / 2 + offsetX + details.focalPointDelta.dx, MediaQuery.of(context).size.height / 2 + offsetY + details.focalPointDelta.dy);
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
            setState(() {
              //zoom = (borderRect.bottom - borderRect.top) / (outputSubrect.bottom - outputSubrect.top);

              if (outputSubrect.left < borderRect.left  && outputSubrect.right > borderRect.right) {
                offsetX += details.focalPointDelta.dx;
                
              }
              if (outputSubrect.top < borderRect.top  && outputSubrect.bottom > borderRect.bottom) {
                offsetY += details.focalPointDelta.dy;
                
              }
            });
          } else if (details.pointerCount == 2) {
            if ((zoom + (details.scale - scale) > zoomX) && (zoom + (details.scale - scale) > zoomY)) {
              var offsetBG = Offset(MediaQuery.of(context).size.width / 2 + offsetX, MediaQuery.of(context).size.height / 2 + offsetY);
              var rect = Rect.fromCenter(center: offsetBG, width: MediaQuery.of(context).size.width * zoom, height: MediaQuery.of(context).size.height * zoom);
              
              final Size imageSize = Size(selectedImage!.width.toDouble(), selectedImage!.height.toDouble());
              final FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, rect.size);
              final Rect outputSubrect =
                      Alignment.center.inscribe(sizes.destination, rect);
              
              //print(outputSubrect);
              var offset = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
              var aspect = MediaQuery.of(context).size.width / 110.0 * 0.6;
              var W = 110.0 * aspect;
              var H = 200.0 * aspect;
              var borderRect = Rect.fromCenter(center: offset, width: W, height: H);
              setState(() {
                zoom += (details.scale - scale);
                // offsetX = (zoom - initZoom) / zoom * offsetX;
                // offsetY = (zoom - initZoom) / zoom * offsetY;
                if (outputSubrect.left >= borderRect.left)
                  offsetX =  outputSubrect.size.width / 2 - W / 2;
                if (outputSubrect.right <= borderRect.right)
                  offsetX = -1 * (outputSubrect.size.width / 2 - W / 2);
                if (outputSubrect.top >= borderRect.top)
                  offsetY = (outputSubrect.size.height / 2 - H / 2);
                if (outputSubrect.bottom <= borderRect.bottom)
                  offsetY = -1 * (outputSubrect.size.height / 2 - H / 2);
                  
              });
              scale = details.scale;
            }
          }
          //print(details.scale);
          //print(details.focalPointDelta);
        },
        onScaleStart: (details) {
          scale = 1.0;
          zoomOffsetX = offsetX;
          zoomOffsetY = offsetY;
        },
        child: CustomPaint(
          child: Container(),
          painter: DesignCanvas(selectedImage, images.length, selectedIndex, offsetX, offsetY, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, zoom),
        ),
      ),
    );
  }

  void loadImages() {
    rootBundle.load("assets/img1.jpg").then((bd) {
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
  }
}
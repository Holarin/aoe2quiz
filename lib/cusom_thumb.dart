import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomThumb extends SliderComponentShape {


  late ui.Image image;

  CustomThumb(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(image.width.toDouble(), image.height.toDouble());
  }



  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation, required Animation<
          double> enableAnimation, required bool isDiscrete, required TextPainter labelPainter, required RenderBox parentBox, required SliderThemeData sliderTheme, required TextDirection textDirection, required double value, required double textScaleFactor, required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    Offset imageOffset = Offset(
      center.dx - (image.width / 2),
      center.dy - (image.height / 2),
    );

    Paint paint = Paint()
      ..filterQuality = FilterQuality.high;

    canvas.drawImage(image, imageOffset, paint);


  }
}
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart' as Vector;

class AnimatedWaveBox extends StatefulWidget {
  final Size size;
  final Color color;
  final double fillFactor;

  AnimatedWaveBox({Key key, @required this.size, this.color, @required this.fillFactor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedWaveBoxState();
}

class _AnimatedWaveBoxState extends State<AnimatedWaveBox> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> polygonOffsets = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));

    animationController.addListener(() {
      polygonOffsets.clear();
      for (int i = 0; i <= widget.size.width.toInt(); i++) {
        polygonOffsets.add(Offset(
            i.toDouble(),
            sin((animationController.value * 360 - i) % 360 * Vector.degrees2Radians) * 10 +
                widget.size.height -
                widget.fillFactor * widget.size.height));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      constraints: BoxConstraints.tight(widget.size),
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.linear,
        ),
        builder: (context, child) => ClipPath(
              child: Container(
                width: widget.size.width,
                height: widget.size.height,
                color: widget.color,
              ),
              clipper: WaveClipper(polygonOffsets: polygonOffsets),
            ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  List<Offset> polygonOffsets = [];

  WaveClipper({@required this.polygonOffsets});

  @override
  Path getClip(Size size) => Path()
    ..addPolygon(polygonOffsets, false)
    ..lineTo(size.width, size.height)
    ..lineTo(0.0, size.height)
    ..close();

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}

class Logo {
  static Path getPath(Size size) {
    final hornHeight = 70.0;
    final hornWidth = 200.0;

    final hornOffsetX = (size.width - hornWidth) / 2 + 30;
    double hornOffsetY = (size.height - hornHeight) / 2 + hornHeight;

    return Path()
      ..moveTo(hornOffsetX, hornOffsetY)
      ..lineTo(hornOffsetX - 012, hornOffsetY - 25)
      ..lineTo(hornOffsetX + 000, hornOffsetY - 22)
      ..lineTo(hornOffsetX + 072, hornOffsetY - 84)
      ..lineTo(hornOffsetX + 099, hornOffsetY - 26)
      ..lineTo(hornOffsetX + 060, hornOffsetY - 21)
      ..lineTo(hornOffsetX + 059, hornOffsetY - 10)
      ..lineTo(hornOffsetX + 014, hornOffsetY - 4)
      ..lineTo(hornOffsetX + 011, hornOffsetY - 13)
      ..lineTo(hornOffsetX + 005, hornOffsetY - 11)
      ..lineTo(hornOffsetX + 000, hornOffsetY);
  }
}

class LogoClipper extends CustomClipper<Path> {
  List<Offset> polygonOffsets = [];

  LogoClipper({@required this.polygonOffsets});

  @override
  Path getClip(Size size) => Logo.getPath(size);

  @override
  bool shouldReclip(LogoClipper oldClipper) => true;
}

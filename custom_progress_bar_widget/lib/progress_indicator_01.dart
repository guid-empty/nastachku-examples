import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart' as Vector;

class WaveBox extends StatefulWidget {
  final Size size;
  final Color color;
  final double fillFactor;

  WaveBox({Key key, @required this.size, this.color, @required this.fillFactor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WaveBoxState();
}

class _WaveBoxState extends State<WaveBox> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> polygonOffsets = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2), value: 0.5);
    animationController.addListener(() {
      polygonOffsets.clear();
      for (int i = 0; i <= widget.size.width.toInt(); i++) {
        polygonOffsets.add(Offset(
            i.toDouble(),
            math.sin((animationController.value * 360 - i) % 360 * Vector.degrees2Radians) * 10 +
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
    final rotateAngle = math.pi / 180.0 * 64;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      constraints: BoxConstraints.tight(widget.size),
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.linear,
        ),
        builder: (context, child) =>







            Transform.rotate(
              angle: -rotateAngle,
              child: Stack(children: <Widget>[
                CustomPaint(
                  size: Size(widget.size.width, widget.size.height),
                  painter: LogoPainter(),
                ),
                ClipPath(
                  child: Transform.rotate(
                    angle: rotateAngle,
                    child: ClipPath(
                      child: Container(
                        width: widget.size.width,
                        height: widget.size.height,
                        color: Colors.orangeAccent
                        ,
                      ),
                      clipper: WaveClipper(polygonOffsets: polygonOffsets),
                    ),
                  ),
                  clipper: LogoClipper(),













                ),
              ]),
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
    final hornHeight = 168.0;
    final hornWidth = 222.0;

    final logoHeight = 280.0;
    final logoWidth = 280.0;
    final logoOffsetX = (size.width - logoWidth) / 2;
    final logoOffsetY = 0.0;

    final hornOffsetX = logoOffsetX + logoWidth / 2 - hornWidth / 2 + 24;
    double hornOffsetY = logoOffsetY + logoHeight / 2 + hornHeight / 2;

    return Path()
      ..moveTo(hornOffsetX, hornOffsetY)
      ..lineTo(hornOffsetX - 024, hornOffsetY - 50)
      ..lineTo(hornOffsetX + 000, hornOffsetY - 44)
      ..lineTo(hornOffsetX + 144, hornOffsetY - 168)
      ..lineTo(hornOffsetX + 198, hornOffsetY - 52)
      ..lineTo(hornOffsetX + 120, hornOffsetY - 42)
      ..lineTo(hornOffsetX + 118, hornOffsetY - 20)
      ..lineTo(hornOffsetX + 028, hornOffsetY - 08)
      ..lineTo(hornOffsetX + 022, hornOffsetY - 26)
      ..lineTo(hornOffsetX + 010, hornOffsetY - 22)
      ..lineTo(hornOffsetX + 000, hornOffsetY);
  }
}

class LogoClipper extends CustomClipper<Path> {
  LogoClipper();

  @override
  Path getClip(Size size) => Logo.getPath(size);

  @override
  bool shouldReclip(LogoClipper oldClipper) => true;
}

class WavePainter extends CustomPainter {
  List<Offset> polygonOffsets = [];

  WavePainter({@required this.polygonOffsets});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow
      ..strokeWidth = 1;

    canvas.drawPath(
        Path()
          ..addPolygon(polygonOffsets, false)
          ..lineTo(size.width, size.height)
          ..lineTo(0.0, size.height)
          ..close(),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..color = Colors.orangeAccent
      ..strokeWidth = 1;

    canvas.drawPath(Logo.getPath(size), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

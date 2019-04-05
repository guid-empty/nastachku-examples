import 'dart:ui' as ui;

void main() {
  ui.window.onBeginFrame = beginFrame;
  ui.window.scheduleFrame();
}

void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = ui.window.devicePixelRatio;
  final ui.Size logicalSize = ui.window.physicalSize / devicePixelRatio;

  final ui.Rect physicalBounds = ui.Offset.zero & (logicalSize * devicePixelRatio);
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder, physicalBounds);
  canvas.scale(devicePixelRatio, devicePixelRatio);

  final paint = ui.Paint()
    ..color = const ui.Color.fromARGB(255, 255, 0, 0)
    ..strokeWidth = 4.0
    ..style = ui.PaintingStyle.fill
    ..strokeCap = ui.StrokeCap.round;

  final backgroundColor = const ui.Color(0xFFFFFFFF);
  final backgroundPaint = ui.Paint()
    ..color = backgroundColor
    ..strokeWidth = 4.0
    ..style = ui.PaintingStyle.fill
    ..strokeCap = ui.StrokeCap.round;

  final hornHeight = 70.0;
  final hornWidth = 100.0;

  final logoHeight = 180.0;
  final logoWidth = 180.0;

  final hornOffsetX = (logicalSize.width - hornWidth) / 2 + 6;
  double hornOffsetY = (logicalSize.height - hornHeight) / 2 + hornHeight;

  canvas
    ..drawColor(backgroundColor, ui.BlendMode.color)
    ..drawRect(
        ui.Rect.fromLTWH(
            (logicalSize.width - logoWidth) / 2, (logicalSize.height - logoHeight) / 2, logoWidth, logoHeight),
        paint);

  canvas
    ..drawPath(
        ui.Path()
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
          ..lineTo(hornOffsetX + 000, hornOffsetY),
        backgroundPaint)
    ..drawPath(
        ui.Path()
          ..moveTo(hornOffsetX + 16, hornOffsetY - 14)
          ..lineTo(hornOffsetX + 17, hornOffsetY - 9)
          ..lineTo(hornOffsetX + 54, hornOffsetY - 15)
          ..lineTo(hornOffsetX + 53, hornOffsetY - 20)
          ..lineTo(hornOffsetX + 16, hornOffsetY - 14),
        paint);

  hornOffsetY += logoHeight + 20;
  canvas
    ..drawPoints(
        ui.PointMode.polygon,
        <ui.Offset>[
          ui.Offset(hornOffsetX, hornOffsetY),
          ui.Offset(hornOffsetX - 012, hornOffsetY - 25),
          ui.Offset(hornOffsetX + 000, hornOffsetY - 22),
          ui.Offset(hornOffsetX + 072, hornOffsetY - 84),
          ui.Offset(hornOffsetX + 099, hornOffsetY - 26),
          ui.Offset(hornOffsetX + 060, hornOffsetY - 21),
          ui.Offset(hornOffsetX + 059, hornOffsetY - 10),
          ui.Offset(hornOffsetX + 014, hornOffsetY - 4),
          ui.Offset(hornOffsetX + 011, hornOffsetY - 13),
          ui.Offset(hornOffsetX + 005, hornOffsetY - 11),
          ui.Offset(hornOffsetX + 000, hornOffsetY),
        ],
        paint)
    ..drawPath(
        ui.Path()
          ..moveTo(hornOffsetX + 16, hornOffsetY - 14)
          ..lineTo(hornOffsetX + 17, hornOffsetY - 9)
          ..lineTo(hornOffsetX + 54, hornOffsetY - 15)
          ..lineTo(hornOffsetX + 53, hornOffsetY - 20)
          ..lineTo(hornOffsetX + 16, hornOffsetY - 14),
        paint);

  final ui.Picture picture = recorder.endRecording();

  final ui.SceneBuilder sceneBuilder = ui.SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(ui.Offset.zero, picture)
    ..pop();

  ui.window.render(sceneBuilder.build());
}

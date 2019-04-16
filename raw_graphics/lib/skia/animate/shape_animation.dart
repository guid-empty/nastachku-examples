import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

Duration start;
void beginFrame(Duration timeStamp) {
  start ??= timeStamp;
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds);

  const Color background = Colors.white; // SK_ColorTRANSPARENT;

  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..drawColor(background, BlendMode.color);

  final shapePaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round
    ..color = Colors.blue;

  final radius = 50.0;
  final x = logicalSize.width / 2;
  final initialY = 10;

  var segment = (timeStamp - start).inMilliseconds /
      Duration.millisecondsPerSecond;
  segment = segment > 1 ? 1 : segment;
  double restPath = (logicalSize.height - radius - initialY) * segment;

  canvas.drawCircle(Offset(x, initialY + restPath), radius, shapePaint);

  final Picture picture = recorder.endRecording();
  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();
  window.render(sceneBuilder.build());
  if (segment < 1) {
    window.scheduleFrame();
  }
}

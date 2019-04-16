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

  var frame = (timeStamp - start).inMilliseconds /
      Duration.millisecondsPerSecond;
  frame = frame > 1 ? 1 : frame;
  double restPath = (logicalSize.height - radius - initialY) * frame;

  canvas.drawCircle(Offset(x, initialY + restPath), radius, shapePaint);

  final Picture picture = recorder.endRecording();
  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();
  window.render(sceneBuilder.build());
  if (frame < 1) {
    window.scheduleFrame();
  }
}

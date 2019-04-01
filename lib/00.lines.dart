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

  final backgroundColor = const ui.Color(0xFFFFFFFF);
  final paint = ui.Paint()
    ..color = const ui.Color.fromARGB(255, 255, 0, 0)
    ..strokeWidth = 10.0
    ..style = ui.PaintingStyle.fill
    ..strokeCap = ui.StrokeCap.round;

  canvas
    ..drawColor(backgroundColor, ui.BlendMode.color)
    ..drawLine(ui.Offset(0, 0), ui.Offset(0, logicalSize.height), paint)
    ..drawLine(ui.Offset(0, 0), ui.Offset(logicalSize.width, 0), paint)
    ..drawLine(ui.Offset(0, 0), ui.Offset(logicalSize.width, logicalSize.height), paint);

  final ui.Picture picture = recorder.endRecording();

  final ui.SceneBuilder sceneBuilder = ui.SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(ui.Offset.zero, picture)
    ..pop();

  ui.window.render(sceneBuilder.build());
}

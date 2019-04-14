import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 3.0,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.orange),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
              child: Row(children: <Widget>[
                getThin(color: Colors.blue),
                getThin(color: Colors.red),
                getFat(color: Colors.green),
              ]),
            ),
          ),
        ),
      ),
    ),
  ));
}

Container getThin({Color color = Colors.blue}) => Container(width: 30, height: 100, color: color);
Container getFat({Color color = Colors.green}) => Container(width: 60, height: 100, color: color);

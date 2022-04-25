import 'package:flutter/material.dart';

class Timeslot {
  Duration time;
  Color color;
  String text;

  Timeslot({
    this.time = const Duration(seconds: 0),
    required this.color,
    this.text = "",
  });

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        "text": text,
        "color": {
          "r": color.red,
          "g": color.green,
          "b": color.blue,
          "a": color.alpha,
        },
        "time": time.inSeconds,
      };
}

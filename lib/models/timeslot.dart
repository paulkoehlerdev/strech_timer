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

  factory Timeslot.fromJson(Map<String, dynamic> data) {
    final time = Duration(seconds: data['time'] as int);
    final text = data['text'] as String;

    final r = data['color']['r'] as int;
    final g = data['color']['g'] as int;
    final b = data['color']['b'] as int;
    final a = data['color']['a'] as int;

    final color = Color.fromARGB(a, r, g, b);

    return Timeslot(time: time, text: text, color: color);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
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

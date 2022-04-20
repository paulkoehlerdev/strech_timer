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
}

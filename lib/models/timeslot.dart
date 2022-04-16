import 'package:flutter/material.dart';

class Timeslot {
  Color color;
  Duration time;
  String text;

  Timeslot(this.color, this.time, [this.text = ""]);
}
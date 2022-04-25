import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';

class Workout {
  late Queue queue;
  IconData icon;
  String name;

  Workout({Queue? queue, this.name = "", this.icon = Icons.sports_gymnastics}) {
    this.queue = queue ?? Queue();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "name": name,
    "queue": queue.toJson(),
  };
}

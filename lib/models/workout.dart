import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';

class Workout {
  late Queue queue;
  IconData icon;
  String name;

  Workout({Queue? queue, this.name = "", this.icon = Icons.sports_gymnastics}) {
    this.queue = queue ?? Queue();
  }

  factory Workout.fromJson(Map<String, dynamic> data){
    final name = data['name'] as String;
    final items = (data['queue'] as List).whereType<Map<String,dynamic>>().toList();
    final queue = Queue.fromJSON(items);
    return Workout(name: name, queue: queue);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "name": name,
    "queue": queue.toJson(),
  };
}

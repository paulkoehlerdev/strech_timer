import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:uuid/uuid.dart';

class Workout {
  late Queue queue;
  late String uuid;
  IconData icon;
  String name;
  bool isDeleted = false;

  Workout({Queue? queue, this.name = "", this.icon = Icons.sports_gymnastics, String? uuid}) {
    this.queue = queue ?? Queue();
    this.uuid = uuid ?? const Uuid().v1();
  }

  factory Workout.fromJson(Map<String, dynamic> data){
    final uuid = data['uuid'] as String;
    final name = data['name'] as String;
    final items = (data['queue'] as List).whereType<Map<String,dynamic>>().toList();
    final queue = Queue.fromJSON(items);
    return Workout(name: name, queue: queue, uuid: uuid);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "uuid": uuid,
    "name": name,
    "queue": queue.toJson(),
  };
}

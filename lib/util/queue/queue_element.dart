import 'package:flutter/cupertino.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';

abstract class QueueElement{

  set parent(Queue parent);
  Queue get parent;
  Key get key;

  QueueElement get next;
  Widget get widget;
  Timeslot get timeslot;

  bool comp(QueueElement other);

  bool add(QueueElement item);
  bool removeAt(int i);
  List<Timeslot> getSlots();
  List<Map<String, dynamic>> toJson();
}
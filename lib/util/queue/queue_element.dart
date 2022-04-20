import 'package:flutter/cupertino.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';

abstract class QueueElement{
  Queue? parent;

  bool add(QueueElement item);
  bool removeAt(int i);

  QueueElement get next;
  Widget get widget;
  Timeslot get timeslot;
}
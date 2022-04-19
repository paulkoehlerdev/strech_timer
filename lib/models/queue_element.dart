import 'package:flutter/cupertino.dart';
import 'package:strech_timer/models/timeslot.dart';

abstract class QueueElement{
  bool add(QueueElement item);

  QueueElement get next;
  Widget get widget;
  Timeslot get timeslot;
}
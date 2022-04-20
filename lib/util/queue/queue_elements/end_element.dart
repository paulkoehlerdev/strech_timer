import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/models/timeslot.dart';

class EndElement implements QueueElement{
  @override
  Queue? parent;

  @override
  QueueElement get next => this;

  @override
  Widget get widget => throw Exception("Bad argument: EndElement has no Widget");

  @override
  Timeslot get timeslot => throw Exception("Bad argument: EndElement has no timeslot");

  @override
  bool add(QueueElement item) => false;

  @override
  bool removeAt(int i) => false;
}
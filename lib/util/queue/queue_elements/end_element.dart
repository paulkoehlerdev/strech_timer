import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/models/timeslot.dart';

class EndElement extends QueueElement{
  @override
  QueueElement get next => this;

  @override
  set parent(Queue parent) => throw Exception("Bad argument: EndElement has no Parent");

  @override
  Queue get parent => throw Exception("Bad argument: EndElement has no Parent");

  @override
  Widget get widget => throw Exception("Bad argument: EndElement has no Widget");

  @override
  Timeslot get timeslot => throw Exception("Bad argument: EndElement has no timeslot");

  @override
  Key get key => throw Exception("Bad argument: EndElement has no key");

  @override
  List<Timeslot> getSlots(){
    return <Timeslot>[];
  }

  @override
  bool comp(QueueElement other) => other is EndElement;

  @override
  bool add(QueueElement item) => false;

  @override
  bool removeAt(int i) => false;
}
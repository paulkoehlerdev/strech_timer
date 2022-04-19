import 'package:flutter/material.dart';
import 'package:strech_timer/models/queue_element.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/widgets/queue_elements/end_element_widget.dart';

class EndElement implements QueueElement{
  @override
  QueueElement get next => throw Exception("Bad argument: EndElement has no next");

  @override
  Widget get widget => const EndElementWidget();

  @override
  Timeslot get timeslot => throw Exception("Bad argument: EndElement has no timeslot");

  @override
  bool add(QueueElement item) => false;
}
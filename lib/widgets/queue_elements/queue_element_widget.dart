import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/queue_elements/repeat_element_widget.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

class QueueElementWidget extends StatelessWidget {
  final QueueElement el;

  const QueueElementWidget(this.el,{  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(el is RepeatElement){
      return RepeatElementWidget.from(el as RepeatElement);
    }
    else if(el is TimeslotElement){
      return TimeslotElementWidget.from(el as TimeslotElement);
    }
    throw Exception("Queue Element not implemented.");
  }
}

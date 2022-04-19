import 'package:flutter/cupertino.dart';
import 'package:strech_timer/models/queue_element.dart';
import 'package:strech_timer/models/queue_elements/end_element.dart';
import 'package:strech_timer/models/queue_elements/return_element.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

class TimeslotElement implements QueueElement{
  QueueElement _next = EndElement();
  Timeslot _timeslot;

  @override
  QueueElement get next => _next;

  @override
  Widget get widget => const TimeslotElementWidget();

  @override
  Timeslot get timeslot => _timeslot;

  TimeslotElement(this._timeslot, {QueueElement? returnElement}){
    if(returnElement != null){
      _next = ReturnElement(returnElement);
    }
  }

  @override
  bool add(QueueElement item) {
    if(!_next.add(item)){
      _next = item;
    }

    return true;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';
import 'package:strech_timer/util/queue/queue_elements/return_element.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

class TimeslotElement implements QueueElement{
  QueueElement _next = EndElement();
  final Timeslot _timeslot;

  @override
  Queue? parent;

  @override
  QueueElement get next => _next;

  @override
  Widget get widget => TimeslotElementWidget(_timeslot, parent: parent,);

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

  @override
  bool removeAt(int i){
    if(i == 0){
      _next = _next.next;
      return true;
    }
    return _next.removeAt(i - 1);
  }
}
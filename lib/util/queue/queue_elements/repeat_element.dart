import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';
import 'package:strech_timer/widgets/queue_elements/repeat_element_widget.dart';
class RepeatElement implements QueueElement {
  int _repetitions = 0;
  final Queue _queue = Queue();
  QueueElement _next = EndElement();

  Queue get queue => _queue;

  @override
  Queue? parent;

  @override
  QueueElement get next => _next;

  @override
  Widget get widget => RepeatElementWidget(_queue, _repetitions, parent: parent,);

  @override
  Timeslot get timeslot => Timeslot(color: Colors.grey);

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
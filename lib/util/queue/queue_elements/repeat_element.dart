import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';
import 'package:strech_timer/widgets/queue_elements/dismissible_queue_element_widget.dart';
class RepeatElement implements QueueElement {
  int repetitions = 0;
  final Queue _queue = Queue();
  QueueElement _next = EndElement();

  RepeatElement(this.repetitions);

  Queue get queue => _queue;

  Queue? _parent;

  @override
  set parent(Queue parent){
    _parent ??= parent;
  }

  @override
  QueueElement get next => _next;

  @override
  Widget get widget => DismissibleQueueElementWidget.repeat(parent: _parent!, childQueue: _queue, repetitions: repetitions);

  @override
  Timeslot get timeslot => Timeslot(color: Colors.grey, time: _queue.getTotalTime());

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
import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';

import '../../../widgets/queue_elements/custom_queue_element_widget.dart';

class RepeatElement implements QueueElement {
  int repetitions = 0;
  final Queue _queue = Queue();
  QueueElement _next = EndElement();

  RepeatElement(this.repetitions) {
    _queue.addListener(() {
      _parent!.executeListener();
    });
  }

  Queue get queue => _queue;

  Queue? _parent;

  @override
  set parent(Queue parent) {
    _parent ??= parent;
  }

  @override
  Queue get parent => _parent!;

  @override
  QueueElement get next => _next;

  @override
  Widget get widget => CustomQueueElementWidget(this);

  @override
  Key get key => ValueKey<Queue>(_queue);

  @override
  Timeslot get timeslot => Timeslot(
        color: Colors.grey,
        time: Duration(
          seconds: _queue.getTotalTime().inSeconds * repetitions,
        ),
      );

  @override
  List<Timeslot> getSlots(){
    final out = _next.getSlots();
    for(int i = 0; i < repetitions; i++) {
      out.addAll(_queue.getSlots().reversed);
    }
    return out;
  }

  @override
  bool comp(QueueElement other) => other is RepeatElement && other.queue == _queue;

  @override
  bool add(QueueElement item) {
    if (!_next.add(item)) {
      _next = item;
    }
    return true;
  }

  @override
  bool removeAt(int i) {
    if (i == 0) {
      _next = _next.next;
      return true;
    }
    return _next.removeAt(i - 1);
  }
}

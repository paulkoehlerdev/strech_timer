import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';

import '../../../widgets/queue_elements/custom_queue_element_widget.dart';

class RepeatElement implements QueueElement {
  int repetitions = 0;
  late final Queue _queue;
  QueueElement _next = EndElement();

  RepeatElement(this.repetitions, {Queue? queue}) {
    _queue = queue ?? Queue();
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


  factory RepeatElement.fromJson(Map<String, dynamic> data) {
    final repetitions = data['repetitions'] as int;
    final items = (data['queue'] as List).whereType<Map<String,dynamic>>().toList();
    final queue = Queue.fromJSON(items);

    return RepeatElement(repetitions, queue: queue);
  }

  @override
  List<Map<String, dynamic>> toJson() {
    List<Map<String,dynamic>> out = _next.toJson();
    Map<String, dynamic> me = <String,dynamic> {
      "type": "repeat",
      "repetitions": repetitions,
      "queue": _queue.toJson(),
    };
    out.insert(0, me);
    return out;
  }

  @override
  List<Timeslot> getSlots(){
    final out = _next.getSlots();
    for(int i = 0; i < repetitions; i++) {
      out.insertAll(0, _queue.getSlots());
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

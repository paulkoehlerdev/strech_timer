import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/queue_elements/add_element_widget.dart';

class Queue {
  QueueElement _root = EndElement();

  final List<VoidCallback> _onChange = <VoidCallback>[];

  QueueIterator get iterator => QueueIterator(_root);

  bool get isEmpty => _root is EndElement;

  Queue();

  factory Queue.fromJSON(List<Map<String, dynamic>> data) {
    Queue queue = Queue();

    data.forEach((element) {
      final type = element['type'] as String;
      if (type == "repeat") {
        queue.add(RepeatElement.fromJson(element));
        return;
      }

      if (type == "timeslot") {
        queue.add(TimeslotElement.fromJson(element));
      }

    });

    return queue;
  }

  void addListener(VoidCallback listener) {
    _onChange.add(listener);
  }

  Future<void> executeListener() async {
    _onChange.forEach((element) {
      element();
    });
  }

  List<Widget> getWidgetList() {
    final out = <Widget>[];
    QueueIterator it = iterator;
    while (it.moveNext()) {
      QueueElement el = it.current;
      out.add(el.widget);
    }
    out.add(AddElementWidget(this));
    return out;
  }

  Duration getTotalTime() {
    Duration total = const Duration(seconds: 0);
    Iterator it = iterator;
    while (it.moveNext()) {
      QueueElement el = it.current;
      total = Duration(seconds: total.inSeconds + el.timeslot.time.inSeconds);
    }
    return total;
  }

  List<Map<String, dynamic>> toJson() {
    return _root.toJson();
  }

  @override
  List<Timeslot> getSlots() {
    return _root.getSlots();
  }

  void add(QueueElement item) {
    item.parent = this;
    if (!_root.add(item)) {
      _root = item;
    }
    executeListener();
  }

  bool removeAt(int i) {
    if (i == 0) {
      _root = _root.next;
      return true;
    }
    bool out = _root.removeAt(i - 1);
    executeListener();
    return out;
  }

  bool comparativeRemove(bool Function(QueueElement a) comp) {
    QueueIterator it = iterator;
    while (it.moveNext()) {
      if (comp(it.current)) {
        removeAt(it.index);
        executeListener();
        return true;
      }
    }
    executeListener();
    return false;
  }
}

class QueueIterator extends Iterator<QueueElement> {
  QueueElement _current;
  int _index = -1;

  @override
  QueueElement get current => _current;

  int get index => _index;

  QueueIterator(this._current);

  @override
  bool moveNext() {
    if (index > -1) {
      _current = _current.next;
    }
    _index++;
    return _current is! EndElement;
  }
}

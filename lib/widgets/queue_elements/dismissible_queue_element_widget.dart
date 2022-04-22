import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/widgets/queue_elements/repeat_element_widget.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

class DismissibleQueueElementWidget extends StatelessWidget {
  final Function(Queue) removeElement;
  final Queue parent;
  final Widget child;

  const DismissibleQueueElementWidget({
    required this.parent,
    required this.removeElement,
    required this.child,
    required Key key,
  }) : super(key: key);

  factory DismissibleQueueElementWidget.timeslot({
    required Queue parent,
    required Timeslot slot,
  }) {
    Widget child = TimeslotElementWidget(slot);
    removeElement(Queue queue){
      queue.comparativeRemove((QueueElement a) => a.timeslot == slot);
    }
    return DismissibleQueueElementWidget(parent: parent, removeElement: removeElement, child: child, key: ValueKey<Timeslot>(slot));
  }

  factory DismissibleQueueElementWidget.repeat({
    required Queue parent,
    required Queue childQueue,
    required int repetitions,
  }) {
    Widget child = RepeatElementWidget(childQueue, repetitions);
    removeElement(Queue queue){
      queue.comparativeRemove((QueueElement a) => childQueue == ((a is RepeatElement) ? a.queue : null));
    }
    return DismissibleQueueElementWidget(parent: parent, removeElement: removeElement, child: child, key: ValueKey<Queue>(childQueue));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: child,
      key: super.key!,
      onDismissed: (direction) {
        removeElement(parent);
      },
      background: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(Icons.delete_forever),
        ),
      ),
      direction: DismissDirection.startToEnd,
    );
  }
}

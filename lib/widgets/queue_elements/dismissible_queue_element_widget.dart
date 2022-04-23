import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/widgets/queue_elements/queue_element_widget.dart';

class DismissibleQueueElementWidget extends StatelessWidget {
  final QueueElement el;
  final Widget child;

  const DismissibleQueueElementWidget(
    this.el, {
    required this.child,
    Key? key,
  }) : super(key: key);

  factory DismissibleQueueElementWidget.from(QueueElement el) {
    return DismissibleQueueElementWidget(el,
        child: QueueElementWidget(el));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: child,
      key: el.key,
      onDismissed: (direction) {
        el.parent.comparativeRemove(el.comp);
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

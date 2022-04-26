import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/widgets/modals/queue_element_modal.dart';
import 'package:strech_timer/widgets/queue_elements/queue_element_widget.dart';

class EditableQueueElementWidget extends StatelessWidget {
  final QueueElement el;
  final Widget child;

  const EditableQueueElementWidget(this.el, {required this.child, Key? key})
      : super(key: key);

  factory EditableQueueElementWidget.from(QueueElement el) {
    return EditableQueueElementWidget(el, child: QueueElementWidget(el));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showQueueElementModal(context, el);
      },
      child: child,
    );
  }
}

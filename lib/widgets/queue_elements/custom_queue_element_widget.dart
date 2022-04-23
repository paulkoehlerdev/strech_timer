import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/widgets/queue_elements/dismissible_queue_element_widget.dart';
import 'package:strech_timer/widgets/queue_elements/editable_queue_element_widget.dart';
import 'package:strech_timer/widgets/queue_elements/queue_element_widget.dart';

class CustomQueueElementWidget extends StatelessWidget {
  final bool isEditable;
  final bool isDismissible;

  final QueueElement element;

  const CustomQueueElementWidget(this.element, {this.isEditable = true, this.isDismissible = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(isDismissible && isEditable){
      return DismissibleQueueElementWidget(element, child: EditableQueueElementWidget.from(element));
    }

    if(isEditable){
      return EditableQueueElementWidget.from(element);
    }

    if(isDismissible){
      return DismissibleQueueElementWidget.from(element);
    }

    return QueueElementWidget(element);
  }
}

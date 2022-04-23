import 'package:flutter/cupertino.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/modals/repeat_element_modal.dart';
import 'package:strech_timer/widgets/modals/timeslot_element_modal.dart';

void showQueueElementModal(BuildContext context, QueueElement el){
  if(el is RepeatElement){
    showRepeatElementModal(context, el.parent, element: el);
  }
  if(el is TimeslotElement){
    showTimeslotElementModal(context, el.parent, element: el);
  }
}
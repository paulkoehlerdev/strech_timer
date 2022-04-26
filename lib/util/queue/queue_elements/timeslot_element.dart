import 'package:flutter/cupertino.dart';
import 'package:strech_timer/util/queue/queue_element.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/end_element.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/widgets/queue_elements/custom_queue_element_widget.dart';

class TimeslotElement implements QueueElement{
  QueueElement _next = EndElement();
  final Timeslot _timeslot;

  Queue? _parent;

  @override
  set parent(Queue parent){
    _parent ??= parent;
  }

  @override
  Queue get parent => _parent!;


  @override
  QueueElement get next => _next;

  @override
  Widget get widget => CustomQueueElementWidget(this);
  
  @override
  Key get key => ValueKey<Timeslot>(_timeslot);

  @override
  Timeslot get timeslot => _timeslot;

  TimeslotElement(this._timeslot);

  factory TimeslotElement.fromJson(Map<String, dynamic> data) {
    final timeslot = Timeslot.fromJson(data['timeslot'] as Map<String,dynamic>);
    return TimeslotElement(timeslot);
  }

  @override
  List<Map<String, dynamic>> toJson() {
    List<Map<String,dynamic>> out = _next.toJson();
    Map<String, dynamic> me = <String,dynamic> {
      "type": "timeslot",
      "timeslot": _timeslot.toJson(),
    };
    out.insert(0, me);
    return out;
  }

  @override
  List<Timeslot> getSlots(){
    final out = _next.getSlots();
    out.insert(0, _timeslot);
    return out;
  }

  @override
  bool comp(QueueElement other) => other is TimeslotElement && other.timeslot == _timeslot;

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
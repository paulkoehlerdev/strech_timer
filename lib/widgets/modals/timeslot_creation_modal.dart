import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/items/close_buttons.dart';
import 'package:strech_timer/widgets/items/color_selector.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

void createTimeslotCreationModal(BuildContext context, Queue queue) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _TimeslotCreationModal(queue),
  );
}

class _TimeslotCreationModal extends StatefulWidget {
  final Queue _queue;
  Timeslot _timeslot = Timeslot(color: Colors.red);

  _TimeslotCreationModal(
    this._queue, {
    Timeslot? timeslot,
    Key? key,
  }) : super(key: key) {
    _timeslot = timeslot ?? _timeslot;
  }

  @override
  State<_TimeslotCreationModal> createState() => _TimeslotCreationModalState();
}

class _TimeslotCreationModalState extends State<_TimeslotCreationModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TimeslotElementWidget(widget._timeslot),
        ),
        ColorSelector(
          widget._timeslot,
          callback: () {
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberPicker(
                axis: Axis.horizontal,
                minValue: 0,
                maxValue: 60,
                value: widget._timeslot.time.inMinutes,
                onChanged: (n) {
                  setState(() {
                    widget._timeslot.time = Duration(
                      minutes: n,
                      seconds: widget._timeslot.time.inSeconds % 60,
                    );
                  });
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                itemCount: 5,
                itemHeight: 60,
                itemWidth: 60,
              ),
              const Text("min"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberPicker(
                  axis: Axis.horizontal,
                  minValue: 0,
                  maxValue: 60,
                  value: widget._timeslot.time.inSeconds % 60,
                  onChanged: (n) {
                    setState(() {
                      widget._timeslot.time = Duration(
                          minutes: widget._timeslot.time.inMinutes, seconds: n);
                    });
                  },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                itemCount: 5,
                itemHeight: 60,
                itemWidth: 60,
              ),
              const Text("sec"),
            ],
          ),
        ),
        const Spacer(),
        CloseButtons(
          onCancel: () {
            Navigator.of(context).pop();
          },
          onDone: () {
            Navigator.of(context).pop();
            widget._queue.add(TimeslotElement(widget._timeslot));
          },
        ),
      ],
    );
  }
}

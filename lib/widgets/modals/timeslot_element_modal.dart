import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/items/close_buttons.dart';
import 'package:strech_timer/widgets/items/color_selector.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

void showTimeslotElementModal(BuildContext context, Queue parent,
    {TimeslotElement? element}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _TimeslotElementModal(parent, element: element),
    isDismissible: false,
  );
}

class _TimeslotElementModal extends StatefulWidget {
  final Queue _queue;
  late TimeslotElement element;
  late bool isNew;

  _TimeslotElementModal(
    this._queue, {
    TimeslotElement? element,
    Key? key,
  }) : super(key: key) {
    isNew = element == null;
    this.element =
        element ?? TimeslotElement(Timeslot(color: Colors.red, text: ""));
  }

  @override
  State<_TimeslotElementModal> createState() => _TimeslotElementModalState();
}

class _TimeslotElementModalState extends State<_TimeslotElementModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TimeslotElementWidget(widget.element.timeslot),
        ),
        ColorSelector(
          widget.element.timeslot,
          callback: () {
            setState(() {});
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberPicker(
                axis: Axis.horizontal,
                minValue: 0,
                maxValue: 60,
                value: widget.element.timeslot.time.inMinutes,
                onChanged: (n) {
                  setState(() {
                    widget.element.timeslot.time = Duration(
                      minutes: n,
                      seconds: widget.element.timeslot.time.inSeconds % 60,
                    );
                  });
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                itemCount: 5,
                itemHeight: 50,
                itemWidth: 50,
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
                value: widget.element.timeslot.time.inSeconds % 60,
                onChanged: (n) {
                  setState(() {
                    widget.element.timeslot.time = Duration(
                        minutes: widget.element.timeslot.time.inMinutes,
                        seconds: n);
                  });
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                itemCount: 5,
                itemHeight: 50,
                itemWidth: 50,
              ),
              const Text("sec"),
            ],
          ),
        ),
        const Spacer(),
        CloseButtons(
          onCancel: () {
            Navigator.of(context).pop();
            widget._queue.executeListener();
          },
          onDone: () {
            Navigator.of(context).pop();
            if (widget.isNew) {
              widget._queue.add(widget.element);
            } else {
              widget._queue.executeListener();
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/widgets/items/close_buttons.dart';
import 'package:strech_timer/widgets/queue_elements/repeat_element_widget.dart';

void createRepeatCreationModal(BuildContext context, Queue queue) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _RepeatCreationModal(queue),
  );
}

class _RepeatCreationModal extends StatefulWidget {
  final Queue _queue;

  const _RepeatCreationModal(this._queue, {Key? key}) : super(key: key);

  @override
  State<_RepeatCreationModal> createState() => _RepeatCreationModalState();
}

class _RepeatCreationModalState extends State<_RepeatCreationModal> {

  int repetitions = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: RepeatElementWidget(
            widget._queue,
            repetitions,
            disableNew: true,
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
                value: repetitions,
                onChanged: (n) {
                  setState(() {
                    repetitions = n;
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
              const Text("Repetitions"),
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
            widget._queue.add(RepeatElement(repetitions));
          },
        ),
      ],
    );
  }
}

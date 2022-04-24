import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/widgets/items/close_buttons.dart';
import 'package:strech_timer/widgets/queue_elements/repeat_element_widget.dart';

void showRepeatElementModal(BuildContext context, Queue queue, {RepeatElement? element}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _RepeatElementModal(queue, element: element),
    isDismissible: false,
    shape: const RoundedRectangleBorder(),
  );
}

class _RepeatElementModal extends StatefulWidget {
  final Queue _queue;
  RepeatElement? element;

  _RepeatElementModal(this._queue, {this.element, Key? key}) : super(key: key);

  @override
  State<_RepeatElementModal> createState() => _RepeatElementModalState();
}

class _RepeatElementModalState extends State<_RepeatElementModal> {
  bool isNew = false;

  @override
  void initState() {
    super.initState();
    isNew = widget.element == null;
    widget.element ??= RepeatElement(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: RepeatElementWidget(
            Queue(),
            widget.element!.repetitions,
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
                minValue: 2,
                maxValue: 20,
                value: widget.element!.repetitions,
                onChanged: (n) {
                  setState(() {
                    widget.element!.repetitions = n;
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
            widget._queue.executeListener();
          },
          onDone: () {
            Navigator.of(context).pop();
            if(isNew){
              widget._queue.add(widget.element!);
            }
            else{
              widget._queue.executeListener();
            }
          },
        ),
      ],
    );
  }
}

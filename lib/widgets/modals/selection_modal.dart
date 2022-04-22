import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/widgets/modals/repeat_creation_modal.dart';
import 'package:strech_timer/widgets/modals/timeslot_creation_modal.dart';

void createSelectionModal(BuildContext context, Queue queue) {
  showModalBottomSheet(
    context: context,
    builder: (context) => _SelectionModal(queue),
  );
}

class _SelectionModal extends StatelessWidget {
  final Queue _queue;

  const _SelectionModal(this._queue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.access_alarm),
          title: const Text("Timeslot"),
          onTap: () {
            Navigator.of(context).pop();
            createTimeslotCreationModal(context, _queue);
          },
        ),
        ListTile(
          leading: const Icon(Icons.repeat),
          title: const Text("Repetition"),
          onTap: () {
            Navigator.of(context).pop();
            createRepeatCreationModal(context, _queue);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.clear,
            color: Colors.red,
          ),
          title: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

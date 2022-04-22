import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/card_tile.dart';

class AddElementWidget extends StatelessWidget {
  final Queue _queue;

  const AddElementWidget(this._queue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      color: Theme.of(context).primaryColor,
      onTap: () {
        _queue.add(
          TimeslotElement(
            Timeslot(color: Colors.red),
          ),
        );
      },
      title: const Icon(Icons.add),
    );
  }
}

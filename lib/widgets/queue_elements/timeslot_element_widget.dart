import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/widgets/card_tile.dart';

class TimeslotElementWidget extends StatelessWidget {
  final Timeslot _timeslot;
  final Queue? parent;

  const TimeslotElementWidget(
    this._timeslot, {
    this.parent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: CardTile(
        color: _timeslot.color,
        title: Text(_timeslot.text),
        trailing: Text("${_timeslot.time}"),
      ),
      key: ValueKey<Timeslot>(_timeslot),
      onDismissed: (direction) {
        _removeElement();
      },
      background: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(Icons.delete_forever),
        ),
      ),
      direction: DismissDirection.startToEnd,
    );
  }

  void _removeElement() {
    parent!.removeTimeslot(_timeslot);
  }
}

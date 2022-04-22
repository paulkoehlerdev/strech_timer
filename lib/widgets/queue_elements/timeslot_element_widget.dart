import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/widgets/card_tile.dart';

class TimeslotElementWidget extends StatelessWidget {
  final Timeslot _timeslot;

  const TimeslotElementWidget(
    this._timeslot, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      color: _timeslot.color,
      title: Text(_timeslot.text),
      trailing: Text("${_timeslot.time}"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/card_tile.dart';
import 'package:strech_timer/widgets/duration_text.dart';

class TimeslotElementWidget extends StatelessWidget {
  final Timeslot _timeslot;

  const TimeslotElementWidget(
    this._timeslot, {
    Key? key,
  }) : super(key: key);

  factory TimeslotElementWidget.from(TimeslotElement el) {
    return TimeslotElementWidget(el.timeslot);
  }

  final TextStyle _textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      color: _timeslot.color,
      title: Text(
        _timeslot.text,
        style: _textStyle,
      ),
      trailing: DurationText(_timeslot.time, style: _textStyle),
    );
  }
}

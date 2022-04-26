import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue_elements/timeslot_element.dart';
import 'package:strech_timer/widgets/items/card_tile.dart';
import 'package:strech_timer/widgets/items/duration_text.dart';

class TimeslotElementWidget extends StatelessWidget {
  final Timeslot _timeslot;
  final bool isEditable;
  final TextEditingController controller = TextEditingController();

  TimeslotElementWidget(
    this._timeslot, {
    this.isEditable = false,
    Key? key,
  }) : super(key: key) {
    controller.text = _timeslot.text;
  }

  factory TimeslotElementWidget.from(TimeslotElement el) {
    return TimeslotElementWidget(el.timeslot);
  }

  final TextStyle _textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      _timeslot.text,
      style: _textStyle,
    );

    if (isEditable) {
      title = TextField(
        controller: controller,
        onChanged: (value) {
          _timeslot.text = value.substring(0, 25);
        },
      );
    }

    return CardTile(
      color: _timeslot.color,
      title: title,
      trailing: DurationText(_timeslot.time, style: _textStyle),
    );
  }
}

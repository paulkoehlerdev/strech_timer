import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';

class TimeslotTile extends StatefulWidget {
  final Timeslot slot;
  final int? index;
  final VoidCallback? onTap;
  final bool remove;
  final VoidCallback? removeCallback;

  const TimeslotTile(this.slot,
      {this.index, this.onTap, this.remove = false, this.removeCallback, Key? key})
      : super(key: key);

  @override
  State<TimeslotTile> createState() => _TimeslotTileState();
}

class _TimeslotTileState extends State<TimeslotTile> {
  @override
  Widget build(BuildContext context) {
    int seconds = widget.slot.time.inSeconds % 60;
    int minutes = (widget.slot.time.inSeconds / 60).floor();
    String text = minutes > 0 ? '$minutes m $seconds s' : '$seconds s';

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        color: widget.slot.color,
        child: ListTile(
          title: Text(text),
          trailing: Text(widget.slot.text),
        ),
      ),
    );
  }
}

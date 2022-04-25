import 'dart:async';

import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/widgets/items/card_tile.dart';
import 'package:strech_timer/widgets/items/duration_text.dart';
import 'package:strech_timer/widgets/queue_elements/timeslot_element_widget.dart';

class WorkoutExecutorView extends StatefulWidget {
  final List<Timeslot> slots;

  WorkoutExecutorView(this.slots, {Key? key}) : super(key: key) {
    if (slots.isEmpty) {
      throw Exception("Invalid Value: slots can't be empty");
    }
  }

  factory WorkoutExecutorView.from(Queue queue) =>
      WorkoutExecutorView(queue.getSlots());

  @override
  State<WorkoutExecutorView> createState() => _WorkoutExecutorViewState();
}

class _WorkoutExecutorViewState extends State<WorkoutExecutorView> {
  int _currentIndex = 0;
  int _elapsedTime = 0;

  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.slots[_currentIndex].time.inSeconds > _elapsedTime++) {
          return;
        }

        if (_currentIndex + 1 >= widget.slots.length) {
          _finishedWorkout();
        } else {
          _currentIndex++;
        }

        _elapsedTime = 0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.slots[_currentIndex].color,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: DurationText(
                Duration(
                  seconds:
                      widget.slots[_currentIndex].time.inSeconds - _elapsedTime,
                ),
                style: const TextStyle(fontSize: 65),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(5.0),
                  child: const Text("Next up:"),
                ),
                (_currentIndex + 1) < widget.slots.length
                    ? TimeslotElementWidget(
                        widget.slots[_currentIndex + 1],
                      )
                    : CardTile(
                        color: Theme.of(context).highlightColor,
                        title: const Text("You're nearly finished!"),
                      ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => _finishedWorkout(),
                    label: const Text(
                      "End",
                      style: TextStyle(color: Colors.red),
                    ),
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _finishedWorkout() {
    Navigator.of(context).pop();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:strech_timer/models/workout.dart';
import 'package:strech_timer/views/workout_executor_view.dart';
import 'package:strech_timer/widgets/card_tile.dart';
import 'package:strech_timer/widgets/duration_text.dart';
import 'package:strech_timer/widgets/workout_editor_widget.dart';

class WorkoutEditorView extends StatefulWidget {
  final Workout workout;

  WorkoutEditorView(this.workout, {Key? key}) : super(key: key);

  @override
  State<WorkoutEditorView> createState() => _WorkoutEditorViewState();
}

class _WorkoutEditorViewState extends State<WorkoutEditorView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Workout"),
        actions: [
          IconButton(
            onPressed: () {
              print(jsonEncode(widget.workout));
            },
            icon: const Icon(Icons.bug_report),
          ),
        ],
      ),
      body: Column(
        children: [
          CardTile(
            title: Text(widget.workout.name),
            leading: Icon(widget.workout.icon),
            trailing: IconButton(
              onPressed: () {
                if (widget.workout.queue.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("You can't start an empty workout"),
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutExecutorView.from(widget.workout.queue),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
            ),
          ),
          ListTile(
            title: const Text("Total Duration: "),
            trailing: DurationText(widget.workout.queue.getTotalTime()),
          ),
          WorkoutEditorWidget(
            workout: widget.workout,
            onChange: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}



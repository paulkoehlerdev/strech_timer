import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:strech_timer/models/workout.dart';
import 'package:strech_timer/util/storage_manager/storage_manager.dart';
import 'package:strech_timer/widgets/items/duration_text.dart';
import 'package:strech_timer/widgets/items/workout_card_tile.dart';
import 'package:strech_timer/widgets/workout_editor_widget.dart';

class WorkoutEditorView extends StatefulWidget {
  final Workout workout;

  const WorkoutEditorView(this.workout, {Key? key}) : super(key: key);

  @override
  State<WorkoutEditorView> createState() => _WorkoutEditorViewState();
}

class _WorkoutEditorViewState extends State<WorkoutEditorView> {

  @override
  void initState() {
    StorageManager();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          WorkoutCardTile(widget.workout),
          ListTile(
            title: const Text("Total Duration: "),
            trailing: DurationText(widget.workout.queue.getTotalTime()),
          ),
          WorkoutEditorWidget(
            workout: widget.workout,
            onChange: () {
              setState(() {
                _saveWorkout();
              });
            },
          ),
        ],
      ),
    );
  }

  void _saveWorkout(){
    StorageManager().writeWorkout(widget.workout);
  }
}



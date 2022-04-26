import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutEditorWidget extends StatelessWidget {
  final Workout workout;
  final VoidCallback? onChange;

  WorkoutEditorWidget({
    required this.workout,
    this.onChange,
    Key? key,
  }) : super(key: key){
    workout.queue.addListener(onChange ?? (){});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: workout.queue.getWidgetList(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:strech_timer/models/workout.dart';
import 'package:strech_timer/views/workout_editor_view.dart';
import 'package:strech_timer/widgets/items/card_tile.dart';

class WorkoutCardTile extends StatelessWidget {
  final Workout workout;

  const WorkoutCardTile(this.workout, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      title: Text(workout.name),
      leading: Icon(workout.icon),
      trailing: IconButton(
        onPressed: () {
          if (workout.queue.isEmpty) {
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
              builder: (context) => WorkoutEditorView(workout),
            ),
          );
        },
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:strech_timer/models/workout.dart';
import 'package:strech_timer/util/storage_manager/storage_manager.dart';
import 'package:strech_timer/views/workout_editor_view.dart';
import 'package:strech_timer/views/workout_executor_view.dart';
import 'package:strech_timer/widgets/items/card_tile.dart';

class WorkoutCardTile extends StatelessWidget {
  final Workout workout;
  final bool editable;
  final bool runnable;
  final bool deletable;
  final bool textbox;
  late final VoidCallback popBackCallback;

  final TextEditingController controller = TextEditingController();

  WorkoutCardTile(
    this.workout, {
    this.editable = false,
    this.runnable = false,
    this.deletable = false,
    this.textbox = false,
    VoidCallback? popBackCallback,
    Key? key,
  }) : super(key: key) {
    this.popBackCallback = popBackCallback ?? () {};
    controller.text = workout.name;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = <Widget>[];

    if (deletable) {
      actions.add(
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Attention"),
                content: Text(
                    'Do you really want to delete the workout ${workout.name} forever?'),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteWorkout(context);
                    },
                  ),
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ),
      );
    }

    if (editable) {
      actions.add(
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutEditorView(workout),
              ),
            ).then((value) => popBackCallback());
          },
          icon: const Icon(Icons.edit),
        ),
      );
    }

    if (runnable) {
      actions.add(
        IconButton(
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
                builder: (context) => WorkoutExecutorView.from(workout.queue),
              ),
            ).then((value) => popBackCallback());
          },
          icon: const Icon(Icons.play_arrow),
        ),
      );
    }

    Widget title = Text(workout.name);

    if (textbox) {
      title = TextField(
        controller: controller,
        onChanged: (value) {
          if (value.length > 20) {
            workout.name = value.substring(0, 20);
          } else {
            workout.name = value;
          }
          StorageManager().writeWorkout(workout);
        },
      );
    }

    return CardTile(
      title: title,
      leading: Icon(workout.icon),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    );
  }

  void _deleteWorkout(BuildContext context) {
    Navigator.of(context).pop();
    popBackCallback();
    StorageManager().deleteWorkout(workout);
  }
}

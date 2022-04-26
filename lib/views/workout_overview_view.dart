import 'package:flutter/material.dart';
import 'package:strech_timer/models/workout.dart';
import 'package:strech_timer/util/storage_manager/storage_manager.dart';
import 'package:strech_timer/views/workout_editor_view.dart';
import 'package:strech_timer/widgets/items/add_tile.dart';
import 'package:strech_timer/widgets/items/workout_card_tile.dart';

class WorkoutOverviewView extends StatefulWidget {
  const WorkoutOverviewView({Key? key}) : super(key: key);

  @override
  State<WorkoutOverviewView> createState() => _WorkoutOverviewViewState();
}

class _WorkoutOverviewViewState extends State<WorkoutOverviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Timer"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Workout>>(
        future: StorageManager().getWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "You have not created any workouts",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    AddTile(
                      onTap: () {
                        _createWorkout(context);
                      },
                    ),
                  ],
                ),
              );
            }
            return _workoutOverview(context, snapshot.data!);
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error!.toString()),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _workoutOverview(BuildContext context, List<Workout> data) {
    final lw = data
        .map(
          (e) => WorkoutCardTile(
            e,
            editable: true,
            runnable: true,
            popBackCallback: () => setState(() { print("callback"); }),
          ),
        )
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          ...lw,
          AddTile(
            onTap: () {
              _createWorkout(context);
            },
          ),
        ],
      ),
    );
  }

  void _createWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutEditorView(Workout()),
      ),
    ).then((value) => setState(() {}));
  }
}

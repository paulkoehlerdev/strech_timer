import 'package:flutter/material.dart';
import 'package:strech_timer/models/workout.dart';
import 'package:strech_timer/util/storage_manager/storage_manager.dart';
import 'package:strech_timer/widgets/items/add_tile.dart';
import 'package:strech_timer/widgets/items/workout_card_tile.dart';

class WorkoutOverviewView extends StatelessWidget {
  const WorkoutOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Timer"),
      ),
      body: FutureBuilder<List<Workout>>(
        future: StorageManager().getWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("You have not created any workouts"),
              );
            }
            return _workoutOverview(snapshot.data!);
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

  Widget _workoutOverview(List<Workout> data) {
    final lw = data.map((e) => WorkoutCardTile(e)).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          ...lw,
          AddTile(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:strech_timer/models/workout.dart';

class StorageManager {
  static final _instance = StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  Future<String> get _localDirectory async {
    final localDir = await getApplicationDocumentsDirectory();
    String workoutDir = '${localDir.path}/workouts/';
    await _ensureDirExists(workoutDir);
    return workoutDir;
  }

  Future<void> _ensureDirExists(String dir) async =>
      await Directory(dir).create();

  Future<List<Workout>> getWorkouts() async => Directory(await _localDirectory)
      .listSync()
      .whereType<File>()
      .where((element) => element.path.endsWith(".json"))
      .map((e) => e.readAsStringSync())
      .map((e) => jsonDecode(e))
      .map((e) => Workout.fromJson(e))
      .toList();

  Future<File> writeWorkout(Workout workout) async {
    final mainDirectory = await _localDirectory;
    final filename = workout.uuid;

    final file = File('$mainDirectory$filename.json');
    print('updated $filename.json');

    return file.writeAsString(jsonEncode(workout));
  }

  Future<bool> deleteWorkout(Workout workout) async {
    final mainDirectory = await _localDirectory;
    final filename = workout.uuid;

    final file = File('$mainDirectory$filename.json');
    print('deleted $filename.json');

    if(!file.existsSync()) return false;

    await file.delete();

    return true;
  }
}

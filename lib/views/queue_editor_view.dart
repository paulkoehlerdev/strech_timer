import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/state_manager/state_manager.dart';
import 'package:strech_timer/widgets/duration_text.dart';

class QueueEditorView extends StatefulWidget {
  const QueueEditorView({Key? key}) : super(key: key);

  @override
  State<QueueEditorView> createState() => _QueueEditorViewState();
}

class _QueueEditorViewState extends State<QueueEditorView> {
  final Queue _queue = Queue();
  bool editing = false;

  @override
  void initState() {
    super.initState();

    StateManager sm = StateManager();
    sm.addState("queue", _queue);
    _queue.addListener (() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var lw = _queue.getWidgetList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Workout"),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text("Total Duration: "),
              trailing: DurationText(_queue.getTotalTime()),
            ),
            ...lw,
          ],
        ),
      ),
    );
  }
}

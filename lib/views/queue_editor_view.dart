import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';
import 'package:strech_timer/util/state_manager/state_manager.dart';

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
        title: Text("Edit Workout"),
        actions: [
          IconButton(
            onPressed: () {
              _queue.add(RepeatElement());
            },
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text("Total Duration: "),
              trailing: Text("${_queue.getTotalTime()}"),
            ),
            ...lw,
          ],
        ),
      ),
    );
  }
}
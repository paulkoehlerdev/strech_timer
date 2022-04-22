import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';

class RepeatElementWidget extends StatefulWidget {
  final Queue queue;
  final int repetitions;

  const RepeatElementWidget(
    this.queue,
    this.repetitions, {
    Key? key,
  }) : super(key: key);

  @override
  State<RepeatElementWidget> createState() => _RepeatElementWidgetState();
}

class _RepeatElementWidgetState extends State<RepeatElementWidget> {
  @override
  void initState() {
    super.initState();
    widget.queue.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.repeat),
            title: Text("Repeating ${widget.repetitions}x"),
            trailing: Text(widget.queue.getTotalTime().toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: widget.queue.getWidgetList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

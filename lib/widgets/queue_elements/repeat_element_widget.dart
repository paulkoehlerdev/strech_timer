import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/widgets/card_tile.dart';

class RepeatElementWidget extends StatefulWidget {
  final Queue queue;
  final int repetitions;
  final bool disableNew;

  const RepeatElementWidget(
    this.queue,
    this.repetitions, {
    this.disableNew = false,
    Key? key,
  }) : super(key: key);

  @override
  State<RepeatElementWidget> createState() => _RepeatElementWidgetState();
}

class _RepeatElementWidgetState extends State<RepeatElementWidget> {
  @override
  void initState() {
    super.initState();
    if (!widget.disableNew) {
      widget.queue.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var wl = widget.queue.getWidgetList();
    if (widget.disableNew) {
      wl.removeLast();
      wl.add(CardTile(
        color: Theme.of(context).highlightColor,
        title: const Text("Example"),
      ));
    }
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
                children: wl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

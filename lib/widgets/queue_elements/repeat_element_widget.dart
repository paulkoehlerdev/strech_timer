import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/util/queue/queue_elements/repeat_element.dart';

class RepeatElementWidget extends StatefulWidget {
  Queue queue;
  Queue? parent;
  int repetitions;

  RepeatElementWidget(
    this.queue,
    this.repetitions, {
    this.parent,
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
    return Dismissible(
      child: Container(
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.repeat),
                title: Text("Repeating ${widget.repetitions}x"),
                trailing: Text(widget.queue.getTotalTime().toString()),
              ),
              Padding(
                padding: EdgeInsets.only(left: 55),
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: widget.queue.getWidgetList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      key: ValueKey<Queue>(widget.queue),
      onDismissed: (direction) {
        _removeElement();
      },
      background: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(Icons.delete_forever),
        ),
      ),
      direction: DismissDirection.startToEnd,
    );
  }

  void _removeElement() {
    QueueIterator it = widget.parent!.iterator;
    while(it.moveNext()){
      if(it.current is RepeatElement){
        if(widget.queue == (it.current as RepeatElement).queue){
          widget.parent!.removeAt(it.index);
          return;
        }
      }
    }
  }
}

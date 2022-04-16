import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/util/bottom_modal.dart';
import 'package:strech_timer/views/color_view.dart';
import 'package:strech_timer/widgets/timeslot_tile.dart';

class TimerCreation extends StatefulWidget {
  const TimerCreation({Key? key}) : super(key: key);

  @override
  State<TimerCreation> createState() => _TimerCreationState();
}

class _TimerCreationState extends State<TimerCreation> {
  final slots = <Timeslot>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strech Timer"),
        actions: [
          IconButton(
            onPressed: () {
              BottomModal.createTimeslotModal(context).then(
                (value) => setState(() {
                  if (value.time.inSeconds != 0) {
                    slots.add(value);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("You have to give a Duration"),
                      ),
                    );
                  }
                }),
              );
            },
            icon: const Icon(Icons.add),
          ),
          slots.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ColorView(slots),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow))
              : Container(),
        ],
      ),
      body: ListView.builder(
        itemCount: slots.length,
        itemBuilder: (context, index) => Dismissible(
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.redAccent,
            child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.clear),
                )),
          ),
          key: ValueKey<Timeslot>(slots[index]),
          onDismissed: (DismissDirection direction) {
            setState(() {
              slots.removeAt(index);
            });
          },
          child: TimeslotTile(slots[index], onTap: () {
            BottomModal.createTimeslotModal(context, slots[index]).then((value) => setState((){}));
          },),
        ),
      ),
    );
  }
}

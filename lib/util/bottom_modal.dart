import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'package:strech_timer/widgets/timeslot_tile.dart';

class BottomModal extends StatefulWidget {
  final Timeslot slot;

  const BottomModal(this.slot, {Key? key}) : super(key: key);

  @override
  State<BottomModal> createState() => _BottomModalState();

  static Future<Timeslot> createTimeslotModal(BuildContext context,
      [Timeslot? timeslot]) async {
    Timeslot output = timeslot ?? Timeslot(Colors.green, Duration(seconds: 0));
    await showModalBottomSheet(
        context: context, builder: (context) => BottomModal(output));
    return output;
  }
}

class _BottomModalState extends State<BottomModal> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TimeslotTile(widget.slot),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens_outlined),
            title: const Text("Select Color"),
            onTap: _selectColor,
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text("Select Duration"),
            onTap: _selectDuration,
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Change Text"),
            onTap: _changeText,
          ),
          ListTile(
            leading: const Icon(Icons.done),
            title: const Text("Done"),
            onTap: _selectDone,
          ),
        ],
      ),
    );
  }

  void _selectDone() {
    Navigator.of(context).pop();
  }

  void _selectColor() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Pick Color"),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: widget.slot.color,
                onColorChanged: (value) => setState(() {
                  widget.slot.color = value;
                }),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _changeText(){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Write Message"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Message",
              ),
              maxLength: 25,
              onChanged: (value)  {
                setState(() {
                  widget.slot.text = value;
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _selectDuration() {
    showDurationPicker(
            context: context,
            initialTime: widget.slot.time,
            baseUnit: BaseUnit.second)
        .then(
      (value) => setState(() {
        widget.slot.time = value ?? const Duration(seconds: 0);
      }),
    );
  }
}

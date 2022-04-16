import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';
import 'dart:async';

class ColorView extends StatefulWidget {
  final List<Timeslot> slots;

  const ColorView(this.slots, {Key? key}) : super(key: key);

  @override
  State<ColorView> createState() => _ColorViewState();
}

class _ColorViewState extends State<ColorView> {
  int _index = 0;
  int _currentTime = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.slots[_index].time.inSeconds;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime--;
        if (_currentTime < 0) {
          _index++;
          if (_index >= widget.slots.length) {
            Navigator.of(context).pop();
          }
          _currentTime = widget.slots[_index].time.inSeconds;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.slots[_index].color,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _timer(),
            Text(
              widget.slots[_index].text,
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timer() {
    String text = "";
    if (_currentTime > 60) {
      int min = (_currentTime / 60).floor();
      int sec = _currentTime % 60;

      text = '$min min $sec s';
    }
    return Text(
      _currentTime.toString() + " s",
      style: const TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DurationText extends StatelessWidget {
  final Duration duration;

  const DurationText(
    this.duration, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";

    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;

    if(minutes > 0){
      text += '$minutes min  ';
    }

    text += '$seconds s';

    return Text(text);
  }
}

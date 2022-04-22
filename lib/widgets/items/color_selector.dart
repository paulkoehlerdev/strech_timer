import 'package:flutter/material.dart';
import 'package:strech_timer/models/timeslot.dart';

class ColorSelector extends StatefulWidget {
  final Timeslot slot;
  final VoidCallback? callback;

  const ColorSelector(
    this.slot, {
    this.callback,
    Key? key,
  }) : super(key: key);

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  final List<Color> _colors = <Color>[
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildColorSwatches(),
    );
  }

  List<Widget> _buildColorSwatches() {
    return _colors
        .map(
          (e) => _ColorSwatch(
            e,
            widget.slot.color == e,
            onPressed: () {
              setState(() {
                if(widget.callback != null) {
                  widget.callback!();
                }
                widget.slot.color = e;
              });
            },
          ),
        )
        .toList();
  }
}

class _ColorSwatch extends StatelessWidget {
  final Color color;
  final bool enabled;
  final VoidCallback? onPressed;

  const _ColorSwatch(
    this.color,
    this.enabled, {
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(enabled ? 8 : 10),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: enabled
                ? const Center(
                    child: Icon(Icons.done),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

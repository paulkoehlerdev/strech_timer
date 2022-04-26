import 'package:flutter/material.dart';

class CloseButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onDone;

  const CloseButtons({
    required this.onCancel,
    required this.onDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: onCancel,
              icon: const Icon(Icons.clear),
              label: const Text("Cancel"),
            ),
          ),
          Expanded(
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: onDone,
              icon: const Icon(Icons.done),
              label: const Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}

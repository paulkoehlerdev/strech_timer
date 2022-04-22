import 'package:flutter/material.dart';
import 'package:strech_timer/util/queue/queue.dart';
import 'package:strech_timer/widgets/card_tile.dart';
import 'package:strech_timer/widgets/modals/selection_modal.dart';

class AddElementWidget extends StatelessWidget {
  final Queue _queue;

  const AddElementWidget(this._queue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      color: Theme.of(context).primaryColor,
      onTap: () {
        createSelectionModal(context, _queue);
      },
      title: const Icon(Icons.add),
    );
  }
}

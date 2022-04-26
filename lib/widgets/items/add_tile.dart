import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strech_timer/widgets/items/card_tile.dart';

class AddTile extends StatelessWidget {
  final VoidCallback? onTap;

  const AddTile({this.onTap, Key? key}) :
    super(key: key,);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      color: Theme.of(context).primaryColor,
      onTap: onTap,
      title: const Icon(Icons.add),
    );
  }
}

import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final Color? color;
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CardTile({
    this.color,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

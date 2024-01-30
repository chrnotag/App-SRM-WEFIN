import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

class AlertDialogGenerico extends StatefulWidget {
  final Icon? icon;
  final String title;
  final String msg;
  final VoidCallback onPressed;

  const AlertDialogGenerico(
      {super.key,
      required this.title,
      required this.msg,
      required this.onPressed,
      this.icon});

  @override
  State<AlertDialogGenerico> createState() => _AlertDialogGenericoState();
}

class _AlertDialogGenericoState extends State<AlertDialogGenerico> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: widget.icon,
      title: Column(
        children: [
          Text(
            widget.title,
            style: context.textTheme.labelMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              widget.msg,
              style: context.textTheme.bodyMedium,
            ),
          ),
          BotaoPadrao(label: 'OK', onPressed: widget.onPressed)
        ],
      ),
    );
  }
}

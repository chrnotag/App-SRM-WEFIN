import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';

class AlertDialogGenerico extends StatefulWidget {
  final IconData? icon;
  final String title;
  final String msg;
  final VoidCallback onPressed;
  final Widget? onPressedSecond;

  const AlertDialogGenerico(
      {super.key,
      required this.title,
      required this.msg,
      required this.onPressed,
      this.onPressedSecond,
      this.icon});

  @override
  State<AlertDialogGenerico> createState() => _AlertDialogGenericoState();
}

class _AlertDialogGenericoState extends State<AlertDialogGenerico> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: widget.icon != null ? Icon(
        widget.icon,
        size: 100.r,
        color: context.primaryColor,
      ) : Container(),
      title: Column(
        children: [
          Text(
            widget.title,
            style: context.textTheme.labelMedium,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
            child: Text(
              widget.msg,
              style: context.textTheme.bodyMedium,
            ),
          ),
          BotaoPadrao(label: 'OK', onPressed: widget.onPressed),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: widget.onPressedSecond ?? Container(),
          )
        ],
      ),
    );
  }
}

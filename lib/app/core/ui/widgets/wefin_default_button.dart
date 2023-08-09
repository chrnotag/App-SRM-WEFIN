import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';

class WefinDefaultButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? color;
  final Color? labelColor;
  final double labelSize;
  final double padding;
  final double width;
  final double height;

  const WefinDefaultButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderRadius = 4,
    this.color,
    this.labelColor,
    this.padding = 0,
    this.labelSize = 20,
    this.width =
        double.infinity, //tamanho maximo da tela, o pai segura o tamanho maximo
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: color ?? AppColors.botaoEnvio,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor ?? AppColors.branco,
          ),
        ),
      ),
    );
  }
}

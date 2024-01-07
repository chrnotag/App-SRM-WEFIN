import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import '../core/constants/themes/theme_configs.dart';

class ComponentCardOperacoes extends StatelessWidget {
  final String title;
  final String label;
  final TextStyle? textStyle;

  const ComponentCardOperacoes(
      {super.key, required this.title, required this.label, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium!
                .copyWith(color: Colors.black),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            label,
            style: textStyle ??
                context.textTheme.bodySmall!
                    .copyWith(color: AppColors.labelText),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

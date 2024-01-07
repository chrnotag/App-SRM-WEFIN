import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import '../../core/constants/themes/theme_configs.dart';

class BotaoPadrao extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;
  final double? fontSize;

  const BotaoPadrao(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.filled = true,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filled
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSizes.paddingMedium.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(
                      icon,
                      size: 40.r,
                    ),
                  ),
                  Text(label,
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: context.onPrimaryColor, fontSize: fontSize))
                ],
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.onPrimaryColor,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: context.primaryColor, width: 2.w),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(
                      icon,
                      color: context.primaryColor,
                      size: 40.r,
                    ),
                  ),
                  Text(label,
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: context.primaryColor, fontSize: fontSize))
                ],
              ),
            ),
          );
  }
}

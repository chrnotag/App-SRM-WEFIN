import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import '../../core/constants/AppSizes.dart';

class BotaoPadrao extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;
  final TextStyle? textStyleFilled;
  final TextStyle? textStyleNoFilled;

  const BotaoPadrao(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.filled = true,
      this.textStyleFilled,
      this.textStyleNoFilled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return filled
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                backgroundColor: context.focusColor),
            child: Padding(
              padding: EdgeInsets.all(AppSizes.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(
                      icon,
                      size: 40.r,
                      color: context.onPrimaryColor,
                    ),
                  ),
                  Text(label,
                      style: textStyleFilled ?? context.textTheme.bodyLarge!
                          .copyWith(color: Colors.white))
                ],
              ),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(
                      icon,
                      color: context.focusColor,
                      size: 40.r,
                    ),
                  ),
                  Text(label,
                      style: textStyleNoFilled ?? context.textTheme.bodyMedium!
                          .copyWith(color: context.focusColor))
                ],
              ),
            ),
          );
  }
}

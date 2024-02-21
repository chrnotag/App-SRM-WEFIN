import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import '../../core/constants/themes/theme_configs.dart';

class BotaoPadrao extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;

  const BotaoPadrao(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.filled = true})
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
                backgroundColor: context.primaryColor),
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
                    ),
                  ),
                  Text(label,
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.onPrimaryColor))
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
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.primaryColor))
                ],
              ),
            ),
          );
  }
}

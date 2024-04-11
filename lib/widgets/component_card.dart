import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import '../core/constants/themes/theme_configs.dart';

class ComponentCardOperacoes extends StatelessWidget {
  final String title;
  final String label;
  final TextStyle? textStyle;
  final bool? centralizar;
  final CrossAxisAlignment? crossAxisAligment;

  const ComponentCardOperacoes(
      {super.key,
      required this.title,
      required this.label,
      this.textStyle,
      this.crossAxisAligment,
      this.centralizar = false});

  @override
  Widget build(BuildContext context) {
    return centralizar!
        ? SizedBox(
            width: 110.w,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    crossAxisAligment ?? CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.labelMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    label,
                    style: textStyle ??
                        context.textTheme.labelMedium!.copyWith(
                            color: AppColors.labelText,
                            fontWeight: FontWeight.w300),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            width: 110.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: crossAxisAligment ?? CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.labelMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  label,
                  style: textStyle ??
                      context.textTheme.labelMedium!.copyWith(
                          color: AppColors.labelText,
                          fontWeight: FontWeight.w300),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
    ;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

import '../../core/constants/themes/theme_configs.dart';

class WefinDefaultButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? labelColor;
  final IconData? icon;
  final bool filled;
  final double? fontSize;

  const WefinDefaultButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.labelColor,
      this.icon,
      this.filled = true,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return filled
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null ? true : false,
                    child: Icon(
                      icon,
                      color: context.onPrimaryColor,
                      size: 40,
                    ),
                  ),
                  Text(
                    label,
                    style: fontSize != null
                        ? context.textTheme.bodySmall!.copyWith(
                            color: context.onPrimaryColor, fontSize: fontSize)
                        : context.textTheme.bodySmall!
                            .copyWith(color: context.onPrimaryColor),
                  )
                ],
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: context.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null ? true : false,
                    child: Icon(
                      icon,
                      color: labelColor ?? context.primaryColor,
                      size: 40,
                    ),
                  ),
                  Text(
                    label,
                    style: fontSize != null
                        ? context.textTheme.bodySmall!.copyWith(
                            color: labelColor ?? context.primaryColor,
                            fontSize: fontSize)
                        : context.textTheme.bodySmall!.copyWith(
                            color: labelColor ?? context.primaryColor),
                  )
                ],
              ),
            ),
          );
    ;
  }
}

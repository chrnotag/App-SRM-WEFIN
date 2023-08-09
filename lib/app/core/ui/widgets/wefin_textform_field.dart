import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/extensions/theme_extension.dart';

import '../theme/globals.dart';

class WefinTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;

  WefinTextFormField(
      {Key? key, required this.label, this.obscureText = false, this.controller, this.validator})
      : _obscureTextVN = ValueNotifier<bool>(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextVNValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: AppSizes.fontSizeMedium, 
                color: AppColors.labelText),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: AppColors.labelText)),
              suffixIcon: obscureText
                  ? IconButton(
                      onPressed: () {
                        _obscureTextVN.value = !obscureTextVNValue;
                      },
                      icon: Icon(
                          obscureTextVNValue ? Icons.remove_red_eye : Icons.lock_open),
                          color: AppColors.labelText,
                    )
                  : null),
        );
      },
    );
  }
}
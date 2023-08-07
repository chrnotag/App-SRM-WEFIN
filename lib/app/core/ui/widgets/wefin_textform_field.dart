import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/extensions/theme_extension.dart';

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
          obscureText: obscureTextVNValue,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)),
              suffixIcon: obscureText
                  ? IconButton(
                      onPressed: () {
                        _obscureTextVN.value = !obscureTextVNValue;
                      },
                      icon: Icon(
                          obscureTextVNValue ? Icons.lock : Icons.lock_open),
                          color: context.primaryColor,
                    )
                  : null),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

import '../../core/constants/themes/theme_configs.dart';

class WefinTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final int? maxLength;
  final VoidCallback? onTap;
  const WefinTextFormField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.maxLength,
      this.onTap})
      : super(key: key);
  @override
  _WefinTextFormFieldState createState() => _WefinTextFormFieldState();
}

class _WefinTextFormFieldState extends State<WefinTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.maxLength,
      style:  TextStyle(
        color: context.onSurface,
      ),
      cursorColor: context.primaryColor,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:
            context.textTheme.bodyMedium!.copyWith(color: AppColors.labelText),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: context.primaryColor),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.labelText,
                ),
              )
            : null,
      ),
      obscureText: _isObscured,
    );
  }
}

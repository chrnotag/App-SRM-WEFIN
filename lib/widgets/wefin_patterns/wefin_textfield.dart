import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import '../../core/constants/themes/theme_configs.dart';

class WefinTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final int? maxLength;
  final VoidCallback? onTap;
  final Color? textColor;
  final TextInputType? inputType;

  const WefinTextFormField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.maxLength,
      this.onTap,
      this.textColor,
      this.inputType})
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
      keyboardType: widget.inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.maxLength,
      style: context.textTheme.bodyMedium!.copyWith(
        color: widget.textColor ?? context.inverseSurface,
      ),
      cursorColor: context.primaryColor,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: context.textTheme.bodyMedium!.copyWith(color: context.onPrimaryColor),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
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

import 'package:flutter/material.dart';
import '../theme/globals.dart';

class WefinTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;

  const WefinTextFormField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      controller: widget.controller,
      validator: widget.validator,
      style: const TextStyle(
        color: AppColors.branco,
      ),
      cursorColor: AppColors.branco,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          fontSize: AppSizes.fontSizeMedium,
          color: AppColors.labelText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.labelText),
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

import 'package:Srm_Asset/core/utils/ambiente_atual.dart';
import 'package:flutter/material.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/services.dart';

import '../../core/constants/tema_configs.dart';

class WefinTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final VoidCallback? onTap;
  final Color? textColor;
  final TextInputType? inputType;
  final TextInputFormatter? inputFormatters;
  final String? autofillHint;
  final ValueChanged<String>? onChanged;
  final int? maxCaracters;

  const WefinTextFormField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.onTap,
      this.textColor,
      this.inputFormatters,
      this.inputType,
      this.autofillHint,
      this.onChanged,
      this.maxCaracters})
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
    List<TextInputFormatter>? formatters =
        widget.inputFormatters != null ? [widget.inputFormatters!] : null;
    return TextFormField(
      autofillHints:
          widget.autofillHint != null ? [widget.autofillHint!] : null,
      maxLength: widget.maxCaracters,
      inputFormatters: formatters,
      onTap: widget.onTap,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.textTheme.bodyMedium!.copyWith(
        color: widget.textColor ?? context.inverseSurface,
      ),
      cursorColor: context.focusColor,
      decoration: InputDecoration(
        errorStyle: context.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.vermelho,
            fontSize: 12.sp),
        labelText: widget.label,
        labelStyle:
            context.textTheme.bodyMedium!.copyWith(color: context.inverseSurface),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.focusColor, width: 2.w),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: VerificarAmbiente.isSRM ? context.focusColor : AppColors.cinzaEscuro,
                width: 1.w)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff874A58), width: 1.w)),
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
                  size: 25.r,
                ),
              )
            : null,
      ),
      obscureText: _isObscured,
    );
  }
}

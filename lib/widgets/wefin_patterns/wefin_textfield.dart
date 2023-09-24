import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';

import '../../core/constants/themes/theme_configs.dart';

class WefinTextFormField extends StatefulWidget {
  //Variaveis de recebimento de parametros
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final int? maxLength;

  //Construtor configurado para receber os parametros
  const WefinTextFormField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.maxLength})
      : super(key: key); //retorna junto ao construtor a superclasse

  @override
  // ignore: library_private_types_in_public_api
  _WefinTextFormFieldState createState() => _WefinTextFormFieldState();
}

class _WefinTextFormFieldState extends State<WefinTextFormField> {
  late bool _isObscured; //Bool que define se o texto é mostrado ou não

  //Inicia o texto com a configuração de obscurecimento passada pelo parametro
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.maxLength,
      style: const TextStyle(
        color: AppColors.branco,
      ),
      cursorColor: AppColors.branco,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:
            context.textTheme.bodyMedium!.copyWith(color: AppColors.labelText),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: UnderlineInputBorder(
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

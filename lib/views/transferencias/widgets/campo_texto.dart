part of '../transferencias_screen.dart';

class _CampoTexto extends StatefulWidget {
  final String tituloCampo;
  final String hint;
  final TextEditingController controller;
  final bool obrigatorio;
  final List<TextInputFormatter> formatos;
  final bool campoMonetario;
  final TextInputType? tipoTeclado;
  final FormFieldValidator<String>? validator;
  final bool campoConta;
  final String? valorCampo;

  _CampoTexto({
    super.key,
    required this.tituloCampo,
    required this.hint,
    required this.controller,
    this.obrigatorio = false,
    this.campoMonetario = false,
    this.validator,
    this.tipoTeclado,
    this.campoConta = false,
    this.valorCampo,
    List<TextInputFormatter>? formatos,
  }) : formatos = formatos ?? [];

  @override
  State<_CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<_CampoTexto> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: widget.tituloCampo,
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            if (widget.obrigatorio)
              TextSpan(
                  text: ' *',
                  style: context.textTheme.bodyLarge!.copyWith(
                      color: context.errorColor, fontWeight: FontWeight.w600))
          ]),
        ),
        TextFormField(
          keyboardType: widget.tipoTeclado,
          inputFormatters: widget.formatos,
          style: context.textTheme.bodyLarge,
          controller: widget.controller,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorStyle: context.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w900,
                color: context.errorColor,
                fontSize: 12.sp),
              hintText: widget.hint,
              border: InputBorder.none,
              hintStyle: context.textTheme.bodyLarge!
                  .copyWith(color: context.labelTextColor),
          prefixText: widget.campoMonetario && widget.controller.text.isNotEmpty ? 'R\$ ' : null,
          prefixStyle: context.textTheme.bodyLarge,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.primaryColor, width: 2.w),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.labelTextColor),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.errorColor, width: 2.w),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.errorColor, width: 2.w),
                borderRadius: const BorderRadius.all(Radius.circular(12))),),
            onChanged: (value) {
            setState(() {
              _formatarNumeroConta();
            });
            },
        ),
      ],
    );
  }
  void _formatarNumeroConta() {
  if(widget.campoConta){
    String text = widget.controller.text;
    text = text.replaceAll('-', ''); // Remove existing hyphen if any
    if (text.length > 1) {
      text = text.substring(0, text.length - 1) + '-' + text.substring(text.length - 1);
    }
    widget.controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(TextPosition(offset: text.length)),
    );
  }
  }
}

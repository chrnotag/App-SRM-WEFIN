part of '../transferencias_screen.dart';

class _CampoTexto extends StatefulWidget {
  final String tituloCampo;
  final String hint;
  final TextEditingController controller;
  final bool obrigatorio;
  final List<TextInputFormatter> formatos;
  final bool campoMonetario;

  _CampoTexto({
    super.key,
    required this.tituloCampo,
    required this.hint,
    required this.controller,
    this.obrigatorio = false,
    this.campoMonetario = false,
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
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: context.labelTextColor),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: TextField(
              inputFormatters: widget.formatos,
              style: context.textTheme.bodyLarge,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  border: InputBorder.none,
                  hintStyle: context.textTheme.bodyLarge!
                      .copyWith(color: context.labelTextColor),
              prefixText: widget.campoMonetario && widget.controller.text.isNotEmpty ? 'R\$ ' : null,
              prefixStyle: context.textTheme.bodyLarge),
                onChanged: (value) {
                setState(() {
                });
                },
            ),
          ),
        ),
      ],
    );
  }
}

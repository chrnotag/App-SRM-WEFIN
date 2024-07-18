part of '../transferencias_screen.dart';

class _CampoDropDown extends StatefulWidget {
  final String tituloCampo;
  final String hint;
  final List<String> dadosDropdown;
  final bool obrigatorio;

  const _CampoDropDown(
      {super.key,
      required this.tituloCampo,
      required this.hint,
      required this.dadosDropdown,
      this.obrigatorio = false});

  @override
  State<_CampoDropDown> createState() => _CampoDropDownState();
}

class _CampoDropDownState extends State<_CampoDropDown> {
  final transferenciaProvider = Modular.get<TransferenciaProvider>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
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
            width: context.width,
            decoration: BoxDecoration(
                border: Border.all(color: context.labelTextColor),
                borderRadius: BorderRadius.all(Radius.circular(12.r))),
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: DropdownButton(
                style: context.textTheme.bodyLarge,
                underline: Container(),
                isExpanded: true,
                value: transferenciaProvider.itemSelecionado,
                items: widget.dadosDropdown
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) =>
                    transferenciaProvider.itemSelecionado = value,
                iconEnabledColor: context.primaryColor,
                iconDisabledColor: context.labelTextColor,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                hint: Text(widget.hint, style: context.textTheme.bodyLarge!.copyWith(color: context.labelTextColor),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

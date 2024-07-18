import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../core/providers/conta_digital/solicitar_ted/solicitar_ted_provider.dart';
import '../../../models/conta_digital/bancos/bancos_model.dart';

class BancoDropdown extends StatefulWidget {
  const BancoDropdown({super.key});

  @override
  State<BancoDropdown> createState() => _BancoDropdownState();
}

class _BancoDropdownState extends State<BancoDropdown> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final solicitarTedProvider = Modular.get<SolicitarTedProvider>();
    return TypeAheadField<BancosModel>(
      controller: controller,
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            onTap: () => setState(() {
                  controller.text = '';
                }),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Selecione seu Banco',
                hintStyle:
                    context.textTheme.bodyLarge!.copyWith(color: Colors.grey)));
      },
      suggestionsCallback: (pattern) async {
        return solicitarTedProvider.listaBancos
            .where((banco) => '${banco.codigo} - ${banco.nome.toLowerCase()}'
                .contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, BancosModel suggestion) {
        return Column(children: [
          Text(
            '${suggestion.codigo} - ${suggestion.nome}',
            textAlign: TextAlign.center,
          ),
          const Divider(
            thickness: 0.1,
          ),
        ]);
      },
      onSelected: (BancosModel suggestion) {
        solicitarTedProvider.bancoSelecionado = suggestion;
        setState(() {
          controller.text =
              '${solicitarTedProvider.bancoSelecionado!.codigo} - ${solicitarTedProvider.bancoSelecionado!.nome}';
        });
      },
      loadingBuilder: (context) => Container(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

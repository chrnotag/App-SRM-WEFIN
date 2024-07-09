import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/providers/transferencias/transferencia_provider.dart';

part 'widgets/campo_dropdown.dart';

part 'widgets/campo_texto.dart';

class Transferencias extends StatefulWidget {
  const Transferencias({super.key});

  @override
  State<Transferencias> createState() => _TransferenciasState();
}

class _TransferenciasState extends State<Transferencias> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerAgencia = TextEditingController();
    final TextEditingController controllerConta = TextEditingController();
    final TextEditingController controllerValor = TextEditingController();
    final TextEditingController controllerNome = TextEditingController();
    final TextEditingController controllerDocumento = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transferência',
          style: context.textTheme.displaySmall!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transferência TED',
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  'Preencha abaixo os dados do favorecido',
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
            _CampoDropDown(
              tituloCampo: 'Instituição bancária',
              hint: 'Selecione a instituição',
              dadosDropdown: [],
              obrigatorio: true,
            ),
            SizedBox(
              width: context.width,
              child: Row(
                children: [
                  Expanded(
                    child: _CampoTexto(
                        tituloCampo: 'Agência',
                        hint: '0000',
                        controller: controllerAgencia),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: _CampoTexto(
                        tituloCampo: 'Conta',
                        hint: '0000000-00',
                        controller: controllerConta),
                  )
                ],
              ),
            ),
            _CampoDropDown(
                tituloCampo: 'Tipo de Conta',
                hint: 'Corrente',
                dadosDropdown: []),
            _CampoTexto(
                tituloCampo: 'Valor',
                hint: 'R\$ 0,00',
                controller: controllerValor),
            _CampoTexto(
                tituloCampo: 'Nome completo',
                hint: 'Nome de quem vai receber',
                controller: controllerNome),
            _CampoTexto(
                tituloCampo: 'CPF/CNPJ',
                hint: 'CPF / CNPJ de quem irá receber',
                controller: controllerDocumento),
            BotaoPadrao(label: 'Solicitar Transferencia', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

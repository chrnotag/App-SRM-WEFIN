import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/enuns/tipo_operacao_enum.dart';
import '../../../core/providers/conta_digital/extrato/extrato_impl.dart';
import '../../../core/providers/conta_digital/extrato/extrato_provider.dart';
import '../tela_extrato/widgets/item_lista_operacao.dart';

class BuildListaOperacao {
  static List<Widget> buildLista(
      {required BuildContext context,
      required int index,
      required TipoConsultaExtrato tipoConsulta}) {
    final extratoProvider = context.watch<ExtratoProvider>();
    bool periodoFixo = tipoConsulta == TipoConsultaExtrato.VISUALIZAR;
    return periodoFixo
        ? extratoProvider.itensExtrato[index].lancamentos
            .map((e) => ItemListaOperacao(
                tipoTED: TipoTED.fromCodigo(e.evento.codigo),
                descricao: e.evento.descricao,
                valorOperacao: e.valor,
                codigoTransacao: e.transacao,
                dataComprovante: e.data.formatarIso8601))
            .toList()
        : extratoProvider.itensExtratoPersonalizado[index].lancamentos
            .map((e) => ItemListaOperacao(
                tipoTED: TipoTED.fromCodigo(e.evento.codigo),
                descricao: e.evento.descricao,
                valorOperacao: e.valor,
                codigoTransacao: e.transacao,
                dataComprovante: e.data.formatarIso8601))
            .toList();
  }
}

import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/enuns/tipo_operacao_enum.dart';
import '../../../core/utils/data_format.dart';
import '../../../core/utils/money_format.dart';
import '../../../models/conta_digital/extrato/conta_extrato_model.dart';
import '../tela_extrato/widgets/item_lista_extrato.dart';
import '../tela_extrato/widgets/item_lista_operacao.dart';

class ExtratosDataSelecionada extends StatefulWidget {
  const ExtratosDataSelecionada({super.key});

  @override
  State<ExtratosDataSelecionada> createState() =>
      _ExtratosDataSelecionadaState();
}

class _ExtratosDataSelecionadaState extends State<ExtratosDataSelecionada> {
  final extratoProvider = Modular.get<ExtratoProvider>();

  @override
  Widget build(BuildContext context) {
    List<Widget> buildOperacoes(int index) {
      List<Widget> lista = [];
      List<Lancamento> lancamentos =
          extratoProvider.itensExtrato[index].lancamentos;
      for (var lancamento in lancamentos) {
        lista.add(ItemListaOperacao(
          tipoTED: TipoTED.fromCodigo(lancamento.evento.codigo),
          descricao: lancamento.evento.descricao,
          valorOperacao: lancamento.valor,
          codigoTransacao: lancamento.transacao,
          dataComprovante: lancamento.data.toIso8601String(),
        ));
      }
      return lista;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('20/02/2024 - 20/05/2024',
            style:
                context.textTheme.displaySmall!.copyWith(color: Colors.white)),
      ),
      body: SizedBox(
        width: context.width * 0.95,
        height: context.height,
        child: Card(
            child: FutureBuilder(
                future: extratoProvider.extratoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loader();
                  }

                  if (snapshot.hasError || snapshot.data!.error != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialogGenerico(
                            title: 'Erro ao carrgar dados',
                            msg:
                                ('Erro ao carregar lista de extratos, tente novamente mais tarde'),
                            onPressed: () {
                              Modular.to.pop();
                              Modular.to.pop();
                            }),
                      );
                    });
                  }
                })),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/datas/operacoes_data.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/operacoes_model/model_operacao.dart';
import 'package:modular_study/views/home/monitor_operacoes/widgets/sliver_app_bar_logo.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/card_operacoes/card_monitor_operacoes.dart';

class MonitorOperacoes extends StatelessWidget {
  const MonitorOperacoes({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final List<OperacaoModel> listOperacoes = OperacoesData.listaOperacoes;
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          const SliverAppBarLogo(),
          SliverPadding(
            padding: EdgeInsets.only(top: 16),
            sliver: SliverToBoxAdapter(
              child: SelecaoEmpresa(
                nomeEmpresa: authProvider.empresaSelecionada!.nome,
                changeble: true,
                label: 'Monitor de Operações',
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CardMonitorOperacoes(
                    operacaoModel: listOperacoes[index], showMoreInfo: false),
                childCount: listOperacoes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/datas/operacoes_data.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/operacoes_model/model_operacao.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/card_operacoes/card_monitor_operacoes.dart';

class MonitorOperacoes extends StatelessWidget {
  const MonitorOperacoes({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final List<List<OperacaoModel>> listOperacoes =
        OperacoesData.listaOperacoes;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBarLogo(),
      ),
      body: Column(
        children: [
          SelecaoEmpresa(
            nomeEmpresa: authProvider.empresaSelecionada!.nome,
            changeble: true,
            tituloPagina: 'Monitor de Operações',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: ListView.builder(
                itemCount: listOperacoes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => CardMonitorOperacoes(
                    operacaoModel: listOperacoes[index], showMoreInfo: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

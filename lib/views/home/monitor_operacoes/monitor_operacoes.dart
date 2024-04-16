import 'package:Srm_Asset/views/home/assinaturas/widgets/popup_erro_carregar_dados.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';
import 'package:Srm_Asset/widgets/botao_selecao_empresa.dart';
import 'package:Srm_Asset/widgets/card_monitor_operacoes/card_monitor_operacoes.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:line_icons/line_icons.dart';

class MonitorOperacoes extends StatefulWidget {
  const MonitorOperacoes({super.key});

  @override
  State<MonitorOperacoes> createState() => _MonitorOperacoesState();
}

class _MonitorOperacoesState extends State<MonitorOperacoes> {
  late Future<ApiResponse<dynamic>> _operacoesFuture;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _operacoesFuture =
          Modular.get<MonitorOperacoesProvider>().carregarOperacoes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    final MonitorOperacoesProvider operacoesProvider =
        Modular.get<MonitorOperacoesProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: TransparentAppBarEmpty(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            SelecaoEmpresa(
              nomeEmpresa: authProvider.empresaSelecionada!.nome,
              changeble: true,
              tituloPagina: 'Monitor de Operações',
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: FutureBuilder(
                future: _operacoesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loader();
                  } else if (snapshot.hasError) {
                    showDialog(
                      context: context,
                      builder: (context) => PopUpErroCarregarDados(),
                    );
                  }
                  if (operacoesProvider.operacoes.isEmpty) {
                    return Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 116.h),
                            child: Icon(LineIcons.clipboardWithCheck,
                                color: context.focusColor,
                                size: 137.r),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 25.h),
                            child: Text(
                              "Não há operações a serem mostradas no momento.",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyLarge!
                                  .copyWith(
                                  color: context.indicatorColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: context.primaryColor,
                      onRefresh: () => _carregarDados(),
                      child: ListView.builder(
                        itemCount: operacoesProvider.operacoes.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CardMonitorOperacoes(
                            operacoes: operacoesProvider.operacoes[index]),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

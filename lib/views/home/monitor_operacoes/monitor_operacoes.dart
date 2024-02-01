import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/implementations_config/api_response.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/card_monitor_operacoes/card_monitor_operacoes.dart';
import 'package:modular_study/widgets/loader_widget.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

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
        child: AppBarLogo(),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          color: AppColors.azulPrimarioSRM,
          onRefresh: () => _carregarDados(),
          displacement: 50.h,
          child: Column(
            children: [
              SelecaoEmpresa(
                nomeEmpresa: authProvider.empresaSelecionada!.nome,
                changeble: true,
                tituloPagina: 'Monitor de Operações',
              ),
              SizedBox(
                height: context.height,
                child: FutureBuilder(
                  future: _operacoesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loader();
                    } else if (snapshot.hasError) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: Icon(
                            LineIcons.exclamationCircle,
                            color: context.primaryColor,
                            size: 20.r,
                          ),
                          title: Column(
                            children: [
                              Text(
                                "Erro ao carregar operações.",
                                style: context.textTheme.labelMedium,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text("Tente novamente mais tarde."),
                              ),
                              BotaoPadrao(
                                  label: 'Ok',
                                  onPressed: () =>
                                      Modular.to.navigate(AppRoutes.homeAppRoute))
                            ],
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                            child: ListView.builder(
                              itemCount: operacoesProvider.operacoes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CardMonitorOperacoes(
                                  operacoes: operacoesProvider.operacoes[index]),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

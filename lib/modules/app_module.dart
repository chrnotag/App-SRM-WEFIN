import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/auth_provider_config/recuperar_senha/recuperar_senha_provider.dart';
import 'package:modular_study/core/providers/documentos_provider/baixar_documentos_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/finalizar_assinatura/finalizar_assinatura_provider.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:modular_study/core/providers/internet_provider.dart';
import 'package:modular_study/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/modules/auth_module.dart';
import 'package:modular_study/modules/home_module.dart';

//Não há necessidade de mecher nesse código
class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(SessionProvider.new);
    i.addSingleton(AuthProvider.new);
    i.addSingleton(AssinaturaProvider.new);
    i.addSingleton(ConnectivityProvider.new);
    i.addSingleton(ImportarCertificadoProvider.new);
    i.addSingleton(ThemeProvider.new);
    i.addSingleton(IniciarAssinaturaProvider.new);
    i.addSingleton(RecuperarSenhaProvider.new);
    i.addSingleton(FinalizarAssinaturaProvider.new);
    i.addSingleton(AssinaturaEletronicaProvider.new);
    i.addSingleton(MonitorOperacoesProvider.new);
    i.addSingleton(BaixarDocumentosProvider.new);
  }

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: AuthModule());
    r.module(AppRoutes.homeRoute, module: HomeModule());
  }
}

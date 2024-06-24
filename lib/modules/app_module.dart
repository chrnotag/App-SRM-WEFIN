import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/carteira_aberto/carteira_aberto_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/geral_carteira/geral_carteira_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/prazo_liquidez/prazo_liquidez_provider.dart';
import 'package:Srm_Asset/core/providers/carteira_consolidada_provider/recebiveis/recebiveis_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/comprovante_ted/comprovante_ted_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/tabbar_meses_provider.dart';
import 'package:Srm_Asset/modules/carteira_consolidada_module.dart';
import 'package:Srm_Asset/modules/conta_digital_module.dart';
import 'package:Srm_Asset/modules/sem_conexao_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/recuperar_senha/recuperar_senha_provider.dart';
import 'package:Srm_Asset/core/providers/documentos_provider/baixar_documentos_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/finalizar_assinatura/finalizar_assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/internet_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_operacao_provider/monitor_operacoes_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/modules/auth_module.dart';
import 'package:Srm_Asset/modules/home_module.dart';

//Não há necessidade de mecher nesse código
class AppModule extends Module {
  final Environment environment;

  AppModule(this.environment);

  @override
  void binds(Injector i) {
    i.addSingleton(SessionProvider.new);
    i.addSingleton(AuthProvider.new);
    i.addSingleton(AssinaturaProvider.new);
    i.addSingleton(ConnectivityProvider.new);
    i.addSingleton(CertificadoProvider.new);
    i.addSingleton(IniciarAssinaturaProvider.new);
    i.addSingleton(RecuperarSenhaProvider.new);
    i.addSingleton(FinalizarAssinaturaProvider.new);
    i.addSingleton(AssinaturaEletronicaProvider.new);
    i.addSingleton(MonitorOperacoesProvider.new);
    i.addSingleton(BaixarDocumentosProvider.new);
    i.addSingleton(ContaDigitalProvider.new);
    i.addSingleton(TabMesesProvider.new);
    i.addSingleton(ExtratoProvider.new);
    i.addSingleton(ComprovanteTEDProvider.new);
    i.addSingleton(GeralCarteiraProvider.new);
    i.addSingleton(CarteiraAbertoProvider.new);
    i.addSingleton(PrazoLiquidezProvider.new);
    i.addSingleton(RecebiveisProvider.new);
    i.addInstance(environment);
  }

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: AuthModule());
    r.module(AppRoutes.homeRoute, module: HomeModule());
    r.module(AppRoutes.semConexaoMainRoute, module: SemConexaoModule());
    r.module(AppRoutes.ContaDigitalRoute, module: ContaDigitalModule());
    r.module(AppRoutes.carteiraConsolidadaRoute,
        module: CarteiraConsolidadaModule());
  }
}

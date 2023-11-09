import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/views/auth/menu_user/menu.dart';
import 'package:modular_study/views/home/ajuda/ajuda_screen.dart';
import 'package:modular_study/views/home/assinaturas/assinatura_digital.dart';
import 'package:modular_study/views/home/home_view/home_view.dart';
import 'package:modular_study/views/home/importar_certificado/importar_certificado.dart';
import 'package:modular_study/views/home/monitor_operacoes/monitor_operacoes.dart';
import 'package:modular_study/views/home/selecao_empresas_view/view_selecao_empresas.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.listaSelecaoEmpresasHomeRoute,
        child: (context) => const ListaSelecaoEmpresas());
    r.child(AppRoutes.helpScreenHomeRoute, child: (context) => const Ajuda());
    r.child(
      AppRoutes.monitorOperacoesHomeRoute,
      child: (context) => const MonitorOperacoes(),
    );
    r.child(
      AppRoutes.assinaturaDigitalHomeRoute,
      child: (context) => const AssinaturaDigital(),
    );
    r.child(
      AppRoutes.menuAppHomeRoute,
      child: (context) => const Menu(),
    );
    r.child(
      AppRoutes.homeAppHomeRoute,
      child: (context) => const HomeView());
    r.child(AppRoutes.importarCertificadoHomeRoute, child: (context) => const ImportarCertificado(),);
  }
}

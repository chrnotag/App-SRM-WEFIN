import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/auth/menu_user/menu.dart';
import 'package:Srm_Asset/views/home/ajuda/ajuda_screen.dart';
import 'package:Srm_Asset/views/home/assinaturas/monitor_assinaturas.dart';
import 'package:Srm_Asset/views/home/home_view/home_view.dart';
import 'package:Srm_Asset/views/home/importar_certificado/guia_certificado.dart';
import 'package:Srm_Asset/views/home/importar_certificado/importar_certificado.dart';
import 'package:Srm_Asset/views/home/importar_certificado/leitor_qrcode.dart';
import 'package:Srm_Asset/views/home/monitor_operacoes/monitor_operacoes.dart';
import 'package:Srm_Asset/views/home/selecao_empresas_view/view_selecao_empresas.dart';

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
      child: (context) => const MonitorAssinaturas(),
    );
    r.child(
      AppRoutes.menuAppHomeRoute,
      child: (context) => const Menu(),
    );
    r.child(AppRoutes.homeAppHomeRoute, child: (context) => const HomeView());
    r.child(
      AppRoutes.importarCertificadoHomeRoute,
      child: (context) => const ImportarCertificado(),
    );
    r.child(
      AppRoutes.guiaImportarCertificadoHomeRoute,
      child: (context) => const GuiaImportCertificado(),
    );
    r.child(AppRoutes.leitorQrCodeHomeRoute,
        child: (context) => const LeitorQrCode());
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/home/ajuda/ajuda_screen.dart';
import 'package:Srm_Asset/views/home/assinaturas/monitor_assinaturas.dart';
import 'package:Srm_Asset/views/home/home_view/home_view.dart';
import 'package:Srm_Asset/views/home/importar_certificado/guia_certificado.dart';
import 'package:Srm_Asset/views/home/importar_certificado/importar_certificado.dart';
import 'package:Srm_Asset/views/home/selecao_empresas_view/view_selecao_empresas.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.listaSelecaoEmpresasModuleRoute,
        child: (context) => const ListaSelecaoEmpresas());
    r.child(AppRoutes.helpScreenModuleRoute, child: (context) => const Ajuda());
    r.child(
      AppRoutes.assinaturaDigitalModuleRoute,
      child: (context) => const MonitorAssinaturas(),
    );
    r.child(AppRoutes.homeAppModuleRoute, child: (context) => const HomeView());
    r.child(
      AppRoutes.importarCertificadoModuleRoute,
      child: (context) => const ImportarCertificado(),
    );
    r.child(
      AppRoutes.guiaImportarCertificadoModuleRoute,
      child: (context) => const GuiaImportCertificado(),
    );
  }
}

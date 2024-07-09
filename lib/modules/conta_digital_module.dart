import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/conta_digital/selecionar_data/extratos_data_selecionada.dart';
import 'package:Srm_Asset/views/conta_digital/selecionar_data/selecionar_data.dart';
import 'package:Srm_Asset/views/conta_digital/ted/comprovante-ted.dart';
import 'package:Srm_Asset/views/conta_digital/tela_extrato/tela_extrato.dart';
import 'package:Srm_Asset/views/conta_digital/tela_extrato/tela_visualizar_pdf.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContaDigitalModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.extratoContaDigitalScreenRoute,
        child: (context) => const TelaExtrato());
    r.child(AppRoutes.selecionarDataContaDigitalScreenRoute,
        child: (context) => const SelecionarDataScreen());
    r.child(
        AppRoutes.visualizarPdfContaDigitalScreenRoute, child: (context) => const TelaVisualizarPdfExtrato());
    r.child(
        AppRoutes.comprovanteTEDContaDigitalScreenRoute + "/:codigoTransacao" + "/:dataComprovante",
        child: (context) => ComprovanteTed(
              codigoTransacao: r.args.params['codigoTransacao'],
            dataComprovante: r.args.params['dataComprovante'],
            ));
    r.child(AppRoutes.extratoDataSelecionadaScreenRoute, child: (context) => const ExtratosDataSelecionada());
  }
}

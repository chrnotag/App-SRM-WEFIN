import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/conta_digital/selecionar_data/selecionar_data.dart';
import 'package:Srm_Asset/views/conta_digital/tela_extrato/tela_extrato.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContaDigitalModule extends Module{
  @override
  void binds(Injector i) {}
  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.extratoScreenContaDigitalRoute, child: (context) => const TelaExtrato());
    r.child(AppRoutes.selecionarDataScreenContaDigitalRoute, child: (context) => const SelecionarDataScreen());
  }
}
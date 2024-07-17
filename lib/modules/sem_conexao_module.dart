import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/auth/sem_conexao/sem_conexao.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SemConexaoModule extends Module{
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.semConexaoMainRoute, child: (context) => const SemConexaoScreen(),);
  }
}
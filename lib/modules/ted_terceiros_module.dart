import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/ted_terceiros/lista_ted_screen/lista_teds_aprovacao_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TedTerceiroModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    // TODO: implement routes
    super.routes(r);
    r.child(
      AppRoutes.tedTerceirosScreenRoute,
      child: (context) => const ListaAprovacaoTed(),
    );
  }
}

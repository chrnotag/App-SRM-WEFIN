import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/carteira_consolidada/carteira_consolidada_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CarteiraConsolidadaModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(AppRoutes.carteiraConsolidadaScreenRoute,
        child: (context) => const CarteiraConsolidadaScreen());
  }
}

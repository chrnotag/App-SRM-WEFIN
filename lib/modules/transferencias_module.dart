import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/transferencias/transferencias_screen.dart';

import '../core/implementations_config/export_impl.dart';

class TransferenciasModule extends Module{
  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.transferenciasScreenRoute, child: (context) => const Transferencias(),);
    super.routes(r);
  }
}
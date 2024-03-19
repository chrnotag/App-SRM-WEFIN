import 'package:flutter_modular/flutter_modular.dart';

import '../constants/route_labels.dart';

class ListaExecaoTimeOut{
  static List<String> get routes => [
    Modular.initialRoute,
    AppRoutes.forgetPassAuthRoute,
    AppRoutes.loginAuthRoute,
    AppRoutes.semConexaoRoute,
    AppRoutes.semConexaoMainRoute
  ];
}
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/modules/auth_module.dart';
import 'package:modular_study/modules/home_module.dart';

//Não há necessidade de mecher nesse código
class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: AuthModule());
    r.module(AppRoutes.homeRoute, module: HomeModule());
  }
}

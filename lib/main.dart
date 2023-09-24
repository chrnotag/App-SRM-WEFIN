import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/app_widget.dart';

import 'modules/app_module.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();
void main() {
  Modular.setNavigatorKey(myNavigatorKey);
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

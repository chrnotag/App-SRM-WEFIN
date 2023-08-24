import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home.dart';

class HomeAppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomeApp(),
      children: [
        ChildRoute('/', child: (_, args) => const HomePage()),
      ],
    ),
  ];
}

import 'package:flutter_mobile_project/app/modules/auth/login/login_controller.dart';
import 'package:flutter_mobile_project/app/modules/auth/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../recuperar/recuperar_senha.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController(
          userService: i(), //AuthModule
          log: i(), //CoreModule
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const LoginPage()),
  ];
}

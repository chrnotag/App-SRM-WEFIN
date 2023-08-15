import 'package:flutter_mobile_project/app/modules/auth/home/auth_home_page.dart';
import 'package:flutter_mobile_project/app/modules/auth/login/login_module.dart';
import 'package:flutter_mobile_project/app/modules/auth/register/register_module.dart';
import 'package:flutter_mobile_project/app/modules/recuperar/recuperar_senha.dart';
import 'package:flutter_mobile_project/app/repositories/user/user_repository.dart';
import 'package:flutter_mobile_project/app/repositories/user/user_repository_impl.dart';
import 'package:flutter_mobile_project/app/services/user/user_service.dart';
import 'package:flutter_mobile_project/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(
          restClient: i(), //CoreModule
          log: i(), //CoreModule
        )),
    Bind.lazySingleton<UserService>((i) => UserServiceImpl(
          userRepository: i(), //AuthModule
          log: i(), //CoreModule
          localStorage: i(), //CoreModule
          localSecureStorage: i(), //CoreModule
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, __) => AuthHomePage(
              authStore: Modular.get(),
            )),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
  ];
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/views/auth/login_view/login_screen.dart';
import 'package:modular_study/views/auth/selecao_empresa_login/selecao_empresa_login.dart';
import 'package:modular_study/views/auth/sem_conexao/sem_conexao.dart';

import '../views/auth/forgot_password_view/forgot_password_screen.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.wildcard(
      child: (context) => const SelecaoEmpresaLogin(),
    );
    r.child(
      AppRoutes.forgetPassAuthRoute,
      child: (context) => const ForgotPasswordScreen(),
    );

    r.child(
      AppRoutes.loginSRMAuthRoute,
      child: (context) => const LoginScreen(),
    );
    r.child(
      AppRoutes.semConexaoAuthRoute,
      child: (context) => const SemConexaoScreen(),
    );
  }
}

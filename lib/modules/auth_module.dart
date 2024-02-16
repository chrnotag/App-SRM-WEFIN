import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/auth/login_view/login_screen.dart';
import 'package:Srm_Asset/views/auth/selecao_empresa_login/selecao_empresa_login.dart';

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
  }
}

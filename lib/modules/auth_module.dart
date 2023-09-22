import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/views/auth/login_view/login_screen.dart';

import '../views/auth/forgot_password_view/forgot_password_screen.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(AuthProvider.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const LoginScreen(),
    );

    r.child(
      AppRoutes.forgetPassAuthRoute,
      child: (context) => const ForgotPasswordScreen(),
    );
  }
}

import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/widgets/dialog_politica_privacidade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:Srm_Asset/widgets/form_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/themes/theme_configs.dart';
import '../../../generated/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? politicaAceita;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.stopListening();
      final AuthProvider authProvider = Modular.get<AuthProvider>();
      authProvider.limparDadosUsuario();
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      politicaAceita = await sharedPreferences.getBool('politica-aceita');
      if (politicaAceita == null || !politicaAceita!) {
        showDialog(
          context: context,
          builder: (context) => PopScope(
              canPop: false,
              onPopInvoked: (didPop) async {
               final bool? statusPolitica = await sharedPreferences.getBool('politica-aceita');
                if (statusPolitica == null || !statusPolitica) {
                  Modular.to.navigate(Modular.initialRoute);
                }
              },
              child: AlertPoliticaPrivacidade()),
          barrierDismissible: false,
          useSafeArea: true,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom != 0;
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesBackgroundImage),
                fit: BoxFit.cover)),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        themeProvider.logoTema,
                        width: isKeyboardVisible ? 80.w : 190.w,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isKeyboardVisible ? 0.0 : 1.0,
                        child: SizedBox(
                          child: Text(
                            "Seja bem vindo\nao seu app de gestão",
                            style: context.textTheme.bodyLarge!
                                .copyWith(color: context.onPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 15.h), // Espaço após a AppBar
                        const AuthForm(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

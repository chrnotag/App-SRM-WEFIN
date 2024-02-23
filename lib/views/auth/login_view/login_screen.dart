import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
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
        child: Column(
          children: [
            if (isKeyboardVisible)
              AppBar(
                title: Image.asset(
                  themeProvider.logoTema,
                  width: 80.w,
                  fit: BoxFit.fill,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: !isKeyboardVisible,
                              child: Image.asset(
                                themeProvider.logoTema,
                                width: 190.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 100.h,
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
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SizedBox(
                              height: context.height * 0.6,
                              child: const AuthForm()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

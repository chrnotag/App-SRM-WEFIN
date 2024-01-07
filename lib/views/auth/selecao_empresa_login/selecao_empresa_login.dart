import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/generated/assets.dart';

import '../../../core/providers/auth_provider_config/logar/auth_providers.dart';
import '../../../core/providers/sessao_provider.dart';

class SelecaoEmpresaLogin extends StatefulWidget {
  const SelecaoEmpresaLogin({super.key});

  @override
  State<SelecaoEmpresaLogin> createState() => _SelecaoEmpresaLoginState();
}

class _SelecaoEmpresaLoginState extends State<SelecaoEmpresaLogin> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.stopListening();
      final AuthProvider authProvider = Modular.get<AuthProvider>();
      authProvider.limparDadosUsuario();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Seja bem-vindo\nao seu app de gestão',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: AppColors.labelText),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.paddingExtraLarge.h),
                        child: Text(
                          'Em qual empresa deseja entrar?',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.labelText),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              themeProvider.temaSelecionado =
                                  TemaSelecionado.SRM;
                              Modular.to.pushNamed(AppRoutes.loginSRMAuthRoute);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.logoSRM,
                                  width: 150.w,
                                  color: AppColors.azul,
                                ),
                                Text(
                                  'CAPITAL EM MOVIMENTO',
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.labelSmall!.copyWith(
                                      color: Color(0xffDE9320),
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizes.paddingMedium.h),
                            child: Text(
                              'ou',
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.azul),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              themeProvider.temaSelecionado =
                                  TemaSelecionado.TRUST;
                              Modular.to.pushNamed(AppRoutes.loginSRMAuthRoute);
                            },
                            child: Image.asset(
                              Assets.logoTRUST,
                              width: 150.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

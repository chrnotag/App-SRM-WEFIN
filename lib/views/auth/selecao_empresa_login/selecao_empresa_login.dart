import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import '../../../core/providers/auth_provider_config/logar/auth_providers.dart';
import '../../../core/providers/sessao_provider.dart';
import '../../../core/constants/AppSizes.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsConfig.imagesBackgroundImage),
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
                            .copyWith(color: context.labelTextColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.paddingExtraLarge.h),
                        child: Text(
                          'Em qual empresa deseja entrar?',
                          style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.labelTextColor),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Modular.to.pushNamed(AppRoutes.loginAuthRoute);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetsConfig.imagesLogoSrm,
                                  width: 150.w,
                                  color: SRMColors.secondaryColor,
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
                                vertical: AppSizes.paddingMedium),
                            child: Text(
                              'ou',
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: SRMColors.secondaryColor),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Modular.to.pushNamed(AppRoutes.loginAuthRoute);
                            },
                            child: Image.asset(
                              AssetsConfig.imagesLogoTrust,
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

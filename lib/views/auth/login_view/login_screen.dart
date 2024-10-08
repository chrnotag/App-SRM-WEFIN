import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/widgets/form_auth.dart';

import '../../../assets_config/assets_config.dart';

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
    final Environment ambiente = Modular.get<Environment>();
    final bool isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsConfig.imagesBackgroundImage),
                fit: BoxFit.cover)),
        child: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              if (isKeyboardVisible)
                AppBar(
                  title: Image.asset(
                    ambiente.logo,
                    width: 80.w,
                    color: context.secondaryColor,
                    fit: BoxFit.fill,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                )
              else
                AppBar(
                  backgroundColor: ambiente.corQuadradoLogin,
                ),
              Visibility(
                visible: !isKeyboardVisible,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: context.width * 0.3,
                    width: context.width,
                    decoration: BoxDecoration(
                        color: ambiente.corQuadradoLogin,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12))),
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            ambiente.logo,
                            width: 190.w,
                            color: ambiente.corImagemLogo,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            ambiente.fraseSloganLogin ?? '',
                            style: context.textTheme.bodyMedium!
                                .copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900,
                                color: context.primaryColor),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isKeyboardVisible ? 0.0 : 1.0,
                      child: SizedBox(
                        child: Text(
                          "Seja bem vindo\nao seu app de gestão",
                          style: context.textTheme.displaySmall!.copyWith(
                            color: context.labelTextColor,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
      ),
    );
  }
}

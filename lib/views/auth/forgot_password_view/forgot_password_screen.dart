import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/widgets/form_auth.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';

import '../../../assets_config/assets_config.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final SessionProvider sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.stopListening();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.height,
        ),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetsConfig.imagesBackgroundImage),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TransparentAppBarEmpty(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: SizedBox(
                            height: 120.h,
                            width: 100.w,
                            child: SvgPicture.asset(
                              AssetsConfig.imagesCadeado,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            'Esqueci Minha Senha',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: context.labelTextColor),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          width: 220.w,
                          child: Text(
                            'Para recuperar sua senha por favor, digite o seu CNPJ e e-mail',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w200,
                                color: context.labelTextColor),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: const AuthForm(
                          label: 'Enviar',
                          visible: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

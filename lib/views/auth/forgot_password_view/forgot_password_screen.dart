import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';
import 'package:modular_study/widgets/form_auth.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';

import '../../../generated/assets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
                  image: AssetImage(Assets.imagesBackgroundImage),
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
                          padding: EdgeInsets.only(bottom: 10.w),
                          child: SizedBox(
                            height: 120.h,
                            width: 100.w,
                            child: SvgPicture.asset(
                              Assets.imagesCadeado,
                            color: context.onSecondary,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            'Esqueci Minha Senha',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w400,
                            color: context.onSecondary),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          width: 220.w,
                          child: Text(
                            'Para recuperar sua senha por favor, digite o seu CPF e e-mail',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w200,
                                color: AppColors.labelText),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: const AuthForm(
                        label: 'Enviar',
                        visible: false,
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

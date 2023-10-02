import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/providers/secao_provider.dart';
import 'package:modular_study/widgets/form_auth.dart';
import 'package:modular_study/widgets/loader_widget.dart';

import '../../../core/constants/themes/theme_configs.dart';
import '../../../generated/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.stopListening();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.imagesLogo,
                          width: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.fill,
                        ), // Espaçamento entre a imagem e o texto
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          child: Text(
                            "Seja bem vindo ao seu app de gestão",
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: AppColors.labelText,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.05 *
                                    MediaQuery.of(context).textScaleFactor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AuthForm(),
                ],
              ),
            ),
          ),
          Visibility(visible: authProvider.isLoading, child: Loader())
        ],
      ),
    );
  }
}

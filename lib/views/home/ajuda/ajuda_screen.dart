import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/enuns/theme_enum.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../generated/assets.dart';

class Ajuda extends StatelessWidget {
  const Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: AppBarLogo()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesIcAjuda,
              width: 150,
              color: isTemaSRM ? Colors.white : context.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Precisa de ajuda?',
                style: context.textTheme.bodyLarge!.copyWith(color: isTemaSRM ? Colors.white : context.shadersTrust[900]),
              ),
            ),
            Text(
              'Pode contar conosco através de um dos nossos canais de atendimento:',
              textAlign: TextAlign.center,
              style: TextStyle(color: isTemaSRM ? Colors.white : context.shadersTrust[900], fontSize: 16),
              softWrap: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Telefone: ',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: isTemaSRM ? Colors.white : context.shadersTrust[900],
                          ),
                        ),
                        TextSpan(
                          text: '0800 878 1005',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: isTemaSRM ? AppColors.azul : context.shadersTrust[700],
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final phoneUrl = Uri.parse('tel:08008781005');
                              if (await canLaunchUrl(phoneUrl)) {
                                await launchUrl(phoneUrl);
                              } else {
                                throw 'Could not launch $phoneUrl';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'E-mail: ',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: isTemaSRM ? Colors.white : context.shadersTrust[900],
                            ),
                          ),
                          TextSpan(
                            text: 'recebiveis@srmasset.com',
                            style: TextStyle(
                                color: isTemaSRM ? AppColors.azul : context.shadersTrust[700],
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final phoneUrl =
                                    Uri.parse('mailto:recebiveis@srmasset.com');
                                if (await canLaunchUrl(phoneUrl)) {
                                  await launchUrl(phoneUrl);
                                } else {
                                  throw 'Could not launch $phoneUrl';
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Politica de privacidade:',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: isTemaSRM ? Colors.white : context.shadersTrust[900],
                          ),
                        ),
                        TextSpan(
                          text: 'Toque aqui',
                          style: TextStyle(
                              color: isTemaSRM ? AppColors.azul : context.shadersTrust[700],
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final filePath =
                                  'assets/Politica-de-privacidade.pdf'; // Substitua isso pelo caminho do seu arquivo
                              final fileUrl = Uri.file(filePath);
                              if (await canLaunchUrl(fileUrl)) {
                                await launchUrl(fileUrl);
                              } else {
                                throw 'Could not launch $fileUrl';
                              }
                            },
                        ),
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/contatos.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../generated/assets.dart';

class Ajuda extends StatelessWidget {
  const Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: AppBarLogo()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesIcAjuda,
              width: 150,
              color: context.onSecondary,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
              child: Text(
                'Precisa de ajuda?',
                style: context.textTheme.bodyLarge!
                    .copyWith(color: context.onSecondary),
              ),
            ),
            Text(
              'Pode contar conosco através de um dos nossos canais de atendimento:',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: context.onSecondary),
              softWrap: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Telefone: ',
                            style: context.textTheme.bodySmall!
                                .copyWith(color: context.onSecondary)),
                        TextSpan(
                          text: isSRM ? Contatos.telefoneSrm : Contatos.telefoneTrust,
                          style: context.textTheme.bodySmall!.copyWith(
                              color: context.onSecondary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final phoneUrl = Uri.parse('tel:${isSRM ? Contatos.telefoneSrm.replaceAll(' ', '') : Contatos.telefoneTrust.replaceAll(' ', '')}');
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
                    padding:
                        EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'E-mail: ',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: context.onSecondary,
                            ),
                          ),
                          TextSpan(
                            text: isSRM ? Contatos.emailSrm : Contatos.emailTrust,
                            style: context.textTheme.bodySmall!.copyWith(
                                color: context.onSecondary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final phoneUrl =
                                    Uri.parse('mailto:${isSRM ? Contatos.emailSrm : Contatos.emailTrust}');
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
                            style: context.textTheme.bodySmall!.copyWith(
                              color: context.onSecondary,
                            )),
                        TextSpan(
                          text: 'Toque aqui',
                          style: context.textTheme.bodySmall!.copyWith(
                              color: context.onSecondary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
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

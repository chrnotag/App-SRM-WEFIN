import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/widgets/transparent_appbar_empty.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/AppSizes.dart';
import '../../../core/utils/abrir_url_externo.dart';

class Ajuda extends StatelessWidget {
  const Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    Environment ambiente = Modular.get<Environment>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: const TransparentAppBarEmpty()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ambiente.imagemAjuda,
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium.h),
              child: Text(
                'Precisa de ajuda?',
                style: context.textTheme.bodyLarge,
              ),
            ),
            Text(
              'Pode contar conosco através de um dos nossos canais de atendimento:',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
              softWrap: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium.h),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Telefone: ',
                            style: context.textTheme.bodyMedium),
                        TextSpan(
                          text: ambiente.contatos.telefone,
                          style: context.textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: context.inverseSurfaceColor,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final phoneUrl = Uri.parse(
                                  'tel:${ambiente.contatos.telefone.replaceAll(" ", "")}');
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
                            style: context.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text:
                              ambiente.contatos.email,
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: context.inverseSurfaceColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final phoneUrl = Uri.parse(
                                    'mailto:${ambiente.contatos.email}');
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
                            style: context.textTheme.bodyMedium),
                        TextSpan(
                          text: 'Toque aqui',
                          style: context.textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: context.inverseSurfaceColor,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = ambiente.endpoints.politicaPrivacidade;
                              AbrirUrl().launchURL(url);
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/contatos.dart';
import 'package:Srm_Asset/core/constants/enuns/theme_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/themes/theme_configs.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:Srm_Asset/widgets/appbar_logo_perfil.dart';
import 'package:Srm_Asset/widgets/pdfview.dart';
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
          preferredSize: AppBar().preferredSize, child: const AppBarLogo()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesIcAjuda,
              width: 150.w,
              color: context.onSecondary,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium.h),
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
              padding: EdgeInsets.symmetric(vertical: AppSizes.paddingMedium.h),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Telefone: ',
                            style: context.textTheme.bodyMedium!
                                .copyWith(color: context.onSecondary)),
                        TextSpan(
                          text: isSRM
                              ? Contatos.telefoneSrm
                              : Contatos.telefoneTrust,
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: context.onSecondary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final phoneUrl = Uri.parse(
                                  'tel:${isSRM ? Contatos.telefoneSrm.replaceAll(' ', '') : Contatos.telefoneTrust.replaceAll(' ', '')}');
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
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.onSecondary,
                            ),
                          ),
                          TextSpan(
                            text:
                                isSRM ? Contatos.emailSrm : Contatos.emailTrust,
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: context.onSecondary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final phoneUrl = Uri.parse(
                                    'mailto:${isSRM ? Contatos.emailSrm : Contatos.emailTrust}');
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
                              color: context.onSecondary,
                            )),
                        TextSpan(
                          text: 'Toque aqui',
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: context.onSecondary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              AuthProvider provider =
                                  Modular.get <AuthProvider>();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfView(
                                        url: provider
                                            .dataUser!.urlPoliticaPrivacidade),
                                  ));
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/widgets/transparent_appbar_empty.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/assets.dart';

class Ajuda extends StatelessWidget {
  const Ajuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: TransparentAppBarEmpty()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesIcAjuda,
              width: 150,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Precisa de ajuda?',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Text(
              'Pode contar conosco através de um dos nossos canais de atendimento:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
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
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: '0800 878 1005',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'E-mail: ',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'recebiveis@srmasset.com',
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Politica de Uso: ',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Click aqui para baixar',
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
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

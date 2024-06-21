import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import '../core/constants/route_labels.dart';
import '../core/providers/monitor_assinatura_provider/assinatura_provider.dart';

class AssinaturaCompletaPopUp extends StatelessWidget {
  final int codigoOperacao;

  const AssinaturaCompletaPopUp({super.key, required this.codigoOperacao});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        Icons.check_circle_outline,
        color: context.focusColor,
        size: 50,
      ),
      title: Column(
        children: [
          Text(
            "Assinatura Digital Confirmada Com Sucesso!",
            style: context.textTheme.labelMedium,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text:
                      'Quando sua operação possuir o numero de assinaturas necessárias, ela passará para o status de ',
                  style: context.textTheme.bodyMedium,
                ),
                TextSpan(
                    text: '\"Assinada\". ',
                    style: context.textTheme.labelMedium),
              ]),
            ),
          ),
          Text(
              'Você pode acompanhar o status da sua assinatura clicando no botão abaixo.',
              style: context.textTheme.bodyMedium),
          BotaoPadrao(
              label: 'Realizar nova assinatura',
              onPressed: () async {
                Modular.to.pop();
                Modular.to.pop();
                await Modular.get<AssinaturaProvider>().carregarDados();
              }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child:
                BotaoPadrao(label: 'Fechar', filled: false, onPressed: () {
                  Modular.to.navigate(AppRoutes.homeAppRoute);
                }),
          ),
        ],
      ),
    );
  }
}

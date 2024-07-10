import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/enuns/enum_ted_terceiros.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_provider.dart';
import 'package:Srm_Asset/models/ted_terceiros/ted_terceiros_model.dart';
import 'package:Srm_Asset/views/ted_terceiros/widgets/item_card_ted.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/botao_comprovante.dart';
import 'widgets/botoes_para_aprovacao.dart';

part 'widgets/card_ted.dart';

class ListaAprovacaoTed extends StatefulWidget {
  const ListaAprovacaoTed({super.key});

  @override
  State<ListaAprovacaoTed> createState() => _ListaAprovacaoTedState();
}

class _ListaAprovacaoTedState extends State<ListaAprovacaoTed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final tedProvider = Modular.get<TedTerceirosProvider>();
    tedProvider.carregarDados();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    final tedProvider = Modular.get<TedTerceirosProvider>();
    tedProvider.limparDados();
  }

  @override
  Widget build(BuildContext context) {
    final ambiente = Modular.get<Environment>();
    final tedProvider = context.watch<TedTerceirosProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aprovação de TED',
          style: context.textTheme.displaySmall!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: tedProvider.futureListaTed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (tedProvider.teds == null ||
              tedProvider.teds!.transferencias.isEmpty) {
            Future.delayed(Duration.zero, () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => PopScope(
                  onPopInvoked: (bool didPop) {
                    Modular.to.navigate(AppRoutes.homeAppNavigatorRoute);
                  },
                  child: AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ambiente.alerta_icone),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Column(
                            children: [
                              Text(
                                'Não há Aprovações disponíveis.',
                                style: context.textTheme.displaySmall!.copyWith(
                                    color: SRMColors.textBodyColor,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'No momento não há nenhuma aprovação a ser feita nesse cedente.',
                                style: context.textTheme.bodyLarge!
                                    .copyWith(color: context.labelTextColor),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Modular.to
                                    .navigate(AppRoutes.homeAppNavigatorRoute),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: context.primaryColor),
                                child: Text(
                                  'Voltar',
                                  style: context.textTheme.bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
            return Container();
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: tedProvider.teds!.transferencias.length,
            itemBuilder: (context, index) => _CardTedTerceiros(
              transferencia: tedProvider.teds!.transferencias[index],
            ),
          );
        },
      ),
    );
  }
}

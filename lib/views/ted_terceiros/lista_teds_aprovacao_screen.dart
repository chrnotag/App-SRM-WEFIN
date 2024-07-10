import 'package:Srm_Asset/core/constants/enuns/enum_ted_terceiros.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_provider.dart';
import 'package:Srm_Asset/models/ted_terceiros/ted_terceiros_model.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/botao_comprovante.dart';
import 'widgets/botoes_para_aprovacao.dart';

part 'widgets/card_ted.dart';

part 'widgets/item_card_ted.dart';

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
          if (tedProvider.teds == null) {
            showDialog(
                context: context,
                builder: (context) => AlertDialogGenerico(
                    title: 'Sem aprovações',
                    msg: 'Não há aprovações disponíveis para esse cedente.',
                    onPressed: () {
                      Modular.to.pop();
                      Modular.to.pop();
                    }));
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

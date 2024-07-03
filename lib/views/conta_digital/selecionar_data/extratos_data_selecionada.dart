import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/core/utils/pdf_manager.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/lista_operacao.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../tela_extrato/widgets/item_lista_extrato.dart';

class ExtratosDataSelecionada extends StatefulWidget {
  const ExtratosDataSelecionada({super.key});

  @override
  State<ExtratosDataSelecionada> createState() =>
      _ExtratosDataSelecionadaState();
}

class _ExtratosDataSelecionadaState extends State<ExtratosDataSelecionada> {
  final extratoProvider = Modular.get<ExtratoProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extratoProvider.carregarDados();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    extratoProvider.limparDados();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${dateFormat.format(extratoProvider.dataInicial)} - ${dateFormat.format(extratoProvider.dataFinal!)}',
            style:
                context.textTheme.displaySmall!.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Image.asset(AssetsConfig.imagesIconePdf, color: Colors.white,),
          onPressed: () async {
            OverlayApp.iniciaOverlay(context);
            await extratoProvider.baixarDadosPeriodo();
            OverlayApp.terminaOverlay();
            final DateFormat dateFormat = DateFormat("dd-MM-yyyy");
            String name = "extrato_${dateFormat.format(extratoProvider.dataFinal!)}_${dateFormat.format(extratoProvider.dataInicial)}";
            print(extratoProvider.extratoDownloadBites ?? 'vazio');
            PDFUtils.sharePDF(extratoProvider.extratoDownloadBites!, name);
          }),
      body: SizedBox(
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
              child: FutureBuilder(
                  future: extratoProvider.extratoFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loader();
                    }

                    if (snapshot.hasError || snapshot.data!.error != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialogGenerico(
                              title: 'Erro ao carrgar dados',
                              msg:
                                  ('Erro ao carregar lista de extratos, tente novamente mais tarde'),
                              onPressed: () {
                                Modular.to.pop();
                                Modular.to.pop();
                              }),
                        );
                      });
                    }

                    return ListView.builder(
                        itemCount: extratoProvider.itensExtrato.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ItemListaExtrato(
                                dataDia: extratoProvider.itensExtrato[index]
                                    .dataReferencia.formatarIso8601,
                                saldoDia: extratoProvider
                                    .itensExtrato[index].saldoNaData.toBRL,
                              ),
                              ...BuildListaOperacao.buildLista(
                                  context: context, index: index),
                            ],
                          );
                        });
                  })),
        ),
      ),
    );
  }
}

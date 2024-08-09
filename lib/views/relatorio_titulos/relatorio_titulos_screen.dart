import 'package:Srm_Asset/core/constants/enuns/enum_selecionar_data_relatorio.dart';
import 'package:Srm_Asset/core/constants/enuns/relatorio_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/relatorio_titulos_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/models/relatorio_titulos/download_boleto/download_boleto_model.dart';
import 'package:Srm_Asset/models/relatorio_titulos/relat%C3%B3rio_model/relatorio_titulos_model.dart';
import 'package:Srm_Asset/views/relatorio_titulos/relatorio_pdf.dart';
import 'package:Srm_Asset/views/relatorio_titulos/widgets/selecionar_data.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/configs_tema/srm/colors.dart';
import '../../models/relatorio_titulos/query_status_model/query_parameters.dart';
import '../../widgets/mensagem_tela_vazia.dart';
import '../../widgets/wefin_patterns/wefin_default_button.dart';

part 'widgets/card_saldo.dart';

part 'widgets/menu_filtro.dart';

part 'widgets/item_menu_filtro.dart';

part 'widgets/alert_status.dart';

class RelatorioTitulosScreen extends StatefulWidget {
  const RelatorioTitulosScreen({super.key});

  @override
  State<RelatorioTitulosScreen> createState() => _RelatorioTitulosScreenState();
}

class _RelatorioTitulosScreenState extends State<RelatorioTitulosScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Modular.get<RelatorioTitulosProvider>();
    provider.futureRelatorio = provider.recuperarTitulos(null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    final provider = Modular.get<RelatorioTitulosProvider>();
    provider.titulos = ListaTitulos(listaTitulos: []);
  }

  @override
  Widget build(BuildContext context) {
    final relatorioProvider = context.watch<RelatorioTitulosProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relatório de titulos',
          style: context.textTheme.displaySmall!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: relatorioProvider.futureRelatorio,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.w, 0, 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Titulos',
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w900,
                              color: SRMColors.textBodyColor),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Consulte seus titulos abaixo',
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: SRMColors.textBodyColor),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: _CardSaldo(
                                valor: relatorioProvider.saldoAVencer())),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: _CardSaldo(
                            valor: relatorioProvider.saldoVencido(),
                            isVencido: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: _MenuFiltro(),
                  ),
                  if(relatorioProvider.titulos.listaTitulos.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Produto',
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w900,
                              color: context.labelTextColor),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Valor',
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w900,
                              color: context.labelTextColor),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Status',
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w900,
                              color: context.labelTextColor),
                        ),
                      )
                    ],
                  ),
                  // Itens roláveis
                  relatorioProvider.titulos.listaTitulos.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: SingleChildScrollView(
                                child: Column(
                              children: relatorioProvider.titulos.listaTitulos
                                  .map((item) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            item.produto.trim(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                                    color:
                                                        SRMColors.textBodyColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                              UtilBrasilFields.obterReal(
                                                  item.valor),
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: SRMColors
                                                          .textBodyColor,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: item.status.corFundo,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.r)),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 14.r),
                                                  child: Text(
                                                    item.status.titulo,
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: item.status
                                                                .corTexto,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100),
                                                  ),
                                                ),
                                              ),
                                              item.status.icone != null
                                                  ? IconButton(
                                                      onPressed: () async {
                                                        final dadosDownload =
                                                            DownloadBoletoModel(
                                                                identificadorSacado:
                                                                    item.identificadorSacado,
                                                                numerosDocumento: [item.documento.toString()]);
                                                        OverlayApp
                                                            .iniciaOverlay(
                                                                context);
                                                        final response =
                                                            await relatorioProvider
                                                                .baixarBoleto(
                                                                    dadosDownload);
                                                        OverlayApp
                                                            .terminaOverlay();
                                                        if (response.error ==
                                                            null) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PdfRelatorioView(),
                                                              ));
                                                        }
                                                      },
                                                      icon: Icon(
                                                        item.status.icone,
                                                        color: context
                                                            .primaryColor,
                                                      ))
                                                  : IconButton(
                                                      onPressed: null,
                                                      icon: Icon(null))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey[300],
                                    )
                                  ],
                                );
                              }).toList(),
                            )),
                          ),
                        )
                      : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MensagemTelaVazia(
                                titulo: 'Não há títulos disponíveis',
                                mensagem:
                                    'Não há títulos para o período ou status selecionado'),
                          ],
                        ),
                      ),
                  if (relatorioProvider.titulos.listaTitulos.isNotEmpty)
                    Center(
                      child: SizedBox(
                        width: context.width * 0.8,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.h, top: 20.h),
                          child: BotaoPadrao(
                              label: 'Salvar PDF',
                              onPressed: () async {
                                OverlayApp.iniciaOverlay(context);
                                final response =
                                    await relatorioProvider.baixarRelatorio(
                                        relatorioProvider.paramsDownload());
                                OverlayApp.terminaOverlay();
                                if (response.error == null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PdfRelatorioView(),
                                      ));
                                }
                              }),
                        ),
                      ),
                    )
                ],
              ),
            );
          }),
    );
  }
}

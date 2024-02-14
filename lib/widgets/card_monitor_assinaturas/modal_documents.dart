import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/widgets/pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/documentos_provider/baixar_documentos_impl.dart';
import 'package:modular_study/core/providers/documentos_provider/baixar_documentos_provider.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

import '../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

class ModalListDocumento extends StatefulWidget {
  final List<Assinante> assinantes;
  final int codigoOperacao;

  const ModalListDocumento(
      {super.key, required this.assinantes, required this.codigoOperacao});

  @override
  State<ModalListDocumento> createState() => _ModalListDocumentoState();
}

class _ModalListDocumentoState extends State<ModalListDocumento> {
  final Set<int> idsUnicos = {};
  final List<Documento> documentosUnicos = [];

  void extrairDocumentosUnicos(List<Assinante> assinantes) {
    for (final assinante in assinantes) {
      for (final informacao in assinante.informacoesAssinante) {
        for (final documento in informacao.documentos) {
          if (!idsUnicos.contains(documento.idAssinaturaDigital)) {
            idsUnicos.add(documento.idAssinaturaDigital);
            documentosUnicos.add(documento);
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    extrairDocumentosUnicos(widget.assinantes);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.r))),
      title: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    topRight: Radius.circular(5.r)),
                color: context.indicatorColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        LineIcons.file,
                        color: Colors.white,
                        size: 30.r,
                      ),
                    ),
                    Text('Lista de documentos',
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: Colors.white))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lista de Documentos',
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: AppColors.azul)),
                      Text('Operação ${widget.codigoOperacao}',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: AppColors.labelText,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: calcularAlturaLista(documentosUnicos.length),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: documentosUnicos.length,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Documento',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors.labelText,
                                  )),
                              SizedBox(
                                width: context.width * 0.4,
                                child: Text(
                                    "${documentosUnicos[index].nome}.pdf",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: AppColors.azul,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  ButtonBar(
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r))),
                                          backgroundColor: AppColors.brancoGelo,
                                        ),
                                        onPressed: () async {
                                          BaixarDocumentosProvider provider =
                                              Modular.get<
                                                  BaixarDocumentosProvider>();
                                          OverlayApp.iniciaOverlay(context);
                                          await BaixarDocumentosImpl(
                                                  documento:
                                                      documentosUnicos[index],
                                                  isVisualizar: true)
                                              .baixar();
                                          OverlayApp.terminaOverlay();
                                          log('url: ${provider.urlDocumento}');
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PdfView(
                                                      documento:
                                                          documentosUnicos[
                                                              index],
                                                      url: provider
                                                          .urlDocumento!),
                                                ));
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              child: Icon(
                                                Icons.visibility,
                                                color: context.indicatorColor,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.w),
                                              child: Text(
                                                'Ver',
                                                style: context
                                                    .textTheme.labelSmall!
                                                    .copyWith(
                                                  color: AppColors.azul,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor:
                                                AppColors.brancoGelo,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.r)))),
                                        onPressed: () async {
                                          OverlayApp.iniciaOverlay(context);
                                         await BaixarDocumentosImpl(
                                                  documento:
                                                      documentosUnicos[index],
                                                  isVisualizar: false)
                                              .baixar();
                                         OverlayApp.terminaOverlay();
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              child: Icon(
                                                Icons.download,
                                                color: context.indicatorColor,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.w),
                                              child: Text('Baixar',
                                                  style: context
                                                      .textTheme.labelSmall!
                                                      .copyWith(
                                                    color: AppColors.azul,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  BotaoPadrao(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    label: 'FECHAR',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double calcularAlturaLista(int itemCount) {
    double alturaTotal = (65 * itemCount).toDouble();
    if (alturaTotal > 500) {
      return 500;
    }
    return alturaTotal;
  }
}

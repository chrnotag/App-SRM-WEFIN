import 'dart:math';
import 'dart:developer' as log;
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:crosspki/crosspki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/finalizar_assinatura/finalizar_assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';

import '../../../../core/constants/themes/theme_configs.dart';

part 'widgets/popup_deletar_certificado.dart';

class SelecionarCertificado extends StatefulWidget {
  const SelecionarCertificado({super.key});

  @override
  State<SelecionarCertificado> createState() => _SelecionarCertificadoState();
}

class _SelecionarCertificadoState extends State<SelecionarCertificado> {
  @override
  void dispose() {
    final ImportarCertificadoProvider certificadoProvider =
        Modular.get<ImportarCertificadoProvider>();
    certificadoProvider.desselecionarCertificado();
    super.dispose();
  }

  bool certificadoSelecionado = false;

  @override
  Widget build(BuildContext context) {
    final ImportarCertificadoProvider certificadoProvider =
        context.watch<ImportarCertificadoProvider>();
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    final double itemHeight = 50.h;
    final double maxHeight = 200.h;
    return AlertDialog(
      title: Column(
        children: [
          Text(
              'Assinar Operação ${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}',
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 15.sp,
                letterSpacing: 1.5.sp,
              )),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Text('Escolha um certificado para assinar a operação:',
                style: context.textTheme.labelSmall!
                    .copyWith(color: AppColors.labelText)),
          ),
          FutureBuilder<List<PKCertificate>>(
            future: CrossPki.listCertificatesWithKey(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: min(
                        certificadoProvider.listaCertificados.length *
                            itemHeight,
                        maxHeight),
                    width: double.maxFinite,
                    // Faz com que o SizedBox ocupe a largura máxima disponível
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            certificadoProvider.listaCertificados.length,
                            (index) {
                          return ListTile(
                            selectedTileColor: context.primaryColor,
                            tileColor: Colors.grey.shade400,
                            selected: certificadoSelecionado,
                            onTap: () {
                              if (certificadoSelecionado == false) {
                                setState(() {
                                  log.log(
                                      'certificado da lista: ${certificadoProvider.listaCertificados[index].thumbprint}');
                                  certificadoProvider.certificadoSelecionado =
                                      certificadoProvider
                                          .listaCertificados[index];
                                  certificadoSelecionado = certificadoProvider
                                      .alterarCorItemListaCertificado(
                                          index, context);
                                });
                              } else {
                                setState(() {
                                  certificadoSelecionado = false;
                                });
                              }
                              log.log('estado: $certificadoSelecionado');
                            },
                            title: Text(
                              certificadoProvider.listaCertificados[index]
                                      .subjectDisplayName ??
                                  "Certificado Sem Nome",
                              style: context.textTheme.bodySmall!
                                  .copyWith(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            trailing: InkWell(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          PopUpDeletarCertificado(
                                                  context: context,
                                                  certificado:
                                                      certificadoProvider
                                                              .listaCertificados[
                                                          index])
                                              .popUp);
                                },
                                child: Icon(Icons.close, color: Colors.black,)),
                          );
                        }),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar os dados.');
                }
              }
              return CircularProgressIndicator();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: certificadoProvider.certificadoSelecionado != null && certificadoSelecionado
                        ? () async {
                            OverlayApp.iniciaOverlay(context);
                            FinalizarAssinaturaProvider finalizarAssinatura =
                                Modular.get<FinalizarAssinaturaProvider>();
                            await finalizarAssinatura.finalizarAssinatura();
                            OverlayApp.terminaOverlay();
                          }
                        : null,
                    label: "Assinar Documento",
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              'Ou',
              style: context.textTheme.bodySmall!
                  .copyWith(color: AppColors.labelText),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BotaoPadrao(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.importarCertificadoRoute);
                    Modular.to.pop();
                  },
                  label: 'Importar Novo Certificado',
                  filled: false,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:crosspki/crosspki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_impl.dart';
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

import '../../../../core/constants/themes/theme_configs.dart';
import '../../../core/constants/enuns/theme_enum.dart';
import '../../../core/providers/theme_provider.dart';

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
                letterSpacing: 1.5,
              )),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Text('Escolha um certificado para assinar a operação:',
                style: context.textTheme.labelSmall!
                    .copyWith(color: AppColors.labelText)),
          ),
          FutureBuilder<List<PKCertificate>>(
            future: certificadoProvider.listaCertificadosFuture(),
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
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              color: certificadoProvider
                                  .alterarCorItemListaCertificado(
                                      certificadoProvider
                                          .certificadoSelecionado ?? null,
                                      context),
                              height: 40.h,
                              child: InkWell(
                                onTap: () {
                                  certificadoProvider
                                      .selecionarCertificadoAssinar(
                                          certificadoProvider
                                              .listaCertificados[index],
                                          context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(certificadoProvider.listaCertificados[index].subjectDisplayName ?? "Certificado Sem Nome",
                                          style: context.textTheme.bodySmall!
                                              .copyWith(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                    InkWell(
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
                                        child: Icon(
                                          Icons.close,
                                          size: 20.r,
                                        ))
                                  ],
                                ),
                              ),
                            ),
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
                    onPressed:
                        certificadoProvider.certificadoSelecionado != null
                            ? () async {

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

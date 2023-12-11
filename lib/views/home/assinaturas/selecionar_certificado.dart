import 'dart:math';
import 'dart:ui';

import 'package:crosspki/crosspki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';

import '../../../../core/constants/themes/theme_configs.dart';

class SelecionarCertificado extends StatelessWidget {
  const SelecionarCertificado({super.key});

  @override
  Widget build(BuildContext context) {
    final ImportarCertificadoProvider certificadoProvider =
        context.watch<ImportarCertificadoProvider>();

    final double itemHeight = 50;
    final double maxHeight = 200;
    return AlertDialog(
      title: Column(
        children: [
          Text('Assinar Operação',
              style: context.textTheme.titleSmall!.copyWith(
                color: AppColors.globalBackground,
                fontWeight: FontWeight.w300,
                fontSize: 15,
                letterSpacing: 1.5,
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                              color: AppColors.labelText,
                              height: 40,
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        certificadoProvider
                                            .listaCertificados[index]
                                            .subjectDisplayName!,
                                        style: context.textTheme.bodySmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Text(
                                                        'Excluir',
                                                        style: context.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                          fontSize: 16,
                                                            color: AppColors.globalBackground),
                                                      ),
                                                    ),
                                                    Text(
                                                        'Você tem certeza que deseja excluir o certifcado?', style: context.textTheme.bodyMedium!.copyWith(),),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: ElevatedButton(
                                                                onPressed: () {
                                                                  certificadoProvider
                                                                      .deletarCertificado(
                                                                          certificadoProvider
                                                                              .listaCertificados[
                                                                                  index]
                                                                              .thumbprint);
                                                                  Modular.to.pop();
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .botaoEnvio,
                                                                ),
                                                                child: const Text(
                                                                    'Excluir')),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Modular.to.pop();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.white,
                                                                shadowColor:
                                                                    Colors
                                                                        .transparent,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                4),
                                                                    side: const BorderSide(
                                                                        color: AppColors
                                                                            .botaoEnvio,
                                                                        width: 1))),
                                                            child: Text(
                                                              'Cancelar',
                                                              style: context.textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .botaoEnvio),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 20,
                                          )),
                                    )
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
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.botaoEnvio,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Assinar Dodumentos'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Ou',
              style: context.textTheme.bodyLarge!
                  .copyWith(fontSize: 16, color: AppColors.labelText),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(
                                color: AppColors.botaoEnvio, width: 1))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Importar novo certificado',
                          style: context.textTheme.bodyLarge!
                              .copyWith(color: AppColors.botaoEnvio),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

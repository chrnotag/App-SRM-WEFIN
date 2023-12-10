part of 'card_monitor_operacoes.dart';

class _ExpansibleInfoCard extends StatefulWidget {
  final bool isVisible;
  final List<Assinantes> assinantes;

  const _ExpansibleInfoCard(
      {super.key, required this.isVisible, required this.assinantes});

  @override
  State<_ExpansibleInfoCard> createState() => __ExpansibleInfoCardState();
}

class __ExpansibleInfoCardState extends State<_ExpansibleInfoCard> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int indicie = 0;

  @override
  Widget build(BuildContext context) {
    final assinantes = widget.assinantes;
    final CarouselController carouselController = CarouselController();
    return widget.isVisible
        ? Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Divider(height: 1, color: AppColors.labelText),
                FlutterCarousel(
                    items: List.generate(
                      assinantes.length,
                      (index) {
                        final assinanteAtual = assinantes[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Papéis',
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: AppColors
                                                          .globalBackground),
                                            ),
                                            if (assinantes.isNotEmpty)
                                              ...assinanteAtual
                                                  .informacoesAssinante
                                                  .expand((assinante) =>
                                                      assinante.papeis
                                                          .map((papel) => Text(
                                                                papel.replaceAll(
                                                                    RegExp(
                                                                        r'[\[\],]'),
                                                                    ''),
                                                                style: context
                                                                    .textTheme
                                                                    .bodySmall,
                                                              )))
                                                  .toList(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Procurador',
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: AppColors
                                                          .globalBackground),
                                            ),
                                            ...assinanteAtual
                                                .informacoesAssinante
                                                .map((procurador) => Text(
                                                      procurador.nomeProcurador != null ?
                                                          procurador.nomeProcurador!.replaceAll(
                                                              RegExp(
                                                                  r'[\[\],]'),
                                                              '') : "",
                                                      style: context
                                                          .textTheme.bodySmall,
                                                    ))
                                                .toList(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status',
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: AppColors
                                                          .globalBackground),
                                            ),
                                            ...assinanteAtual
                                                .informacoesAssinante
                                                .map((status) => Text(
                                                      status.statusAssinatura
                                                          .replaceAll(
                                                              RegExp(
                                                                  r'[\[\],]'),
                                                              ''),
                                                      style: context
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              color: CorOperacao
                                                                  .definirCorAssinante(
                                                                      assinanteAtual)),
                                                    ))
                                                .toList(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Assinante',
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: AppColors
                                                          .globalBackground),
                                            ),
                                            Text(
                                              assinanteAtual.nomeAssinante
                                                  .replaceAll(
                                                      RegExp(r'[\[\],]'), ''),
                                              style:
                                                  context.textTheme.bodySmall,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Documentos',
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: AppColors
                                                        .globalBackground),
                                          ),
                                          ...assinanteAtual.informacoesAssinante
                                              .expand((assinante) => assinante
                                                  .documentos
                                                  .map((documento) => Text(
                                                        documento.nome
                                                            .replaceAll(
                                                                RegExp(
                                                                    r'[\[\],]'),
                                                                ''),
                                                        style: context.textTheme
                                                            .bodySmall,
                                                      )))
                                              .toList(),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tipo de Assinatura',
                                              style: context
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: AppColors
                                                          .globalBackground),
                                            ),
                                            ...assinanteAtual
                                                .informacoesAssinante
                                                .map((tipoAssinatura) => Text(
                                                      tipoAssinatura
                                                          .tipoAssinatura
                                                          .replaceAll(
                                                              RegExp(
                                                                  r'[\[\],]'),
                                                              ''),
                                                      style: context
                                                          .textTheme.bodySmall,
                                                    ))
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Data',
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: AppColors
                                                        .globalBackground),
                                          ),
                                          ...assinanteAtual.informacoesAssinante
                                              .map((dataAssinatura) => Text(
                                                    dataAssinatura
                                                        .dataAssinatura != null ?
                                                        dataAssinatura.dataAssinatura!.replaceAll(
                                                            RegExp(r'[\[\],]'),
                                                            '') : "",
                                                    style: context
                                                        .textTheme.bodySmall,
                                                  ))
                                              .toList(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Column(
                                            children: [
                                              Text('Assinar Operação',
                                                  style: context
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                    color: AppColors
                                                        .globalBackground,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    letterSpacing: 1.5,
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                    'Escolha como assinar a operação:',
                                                    style: context
                                                        .textTheme.labelSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .labelText)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            12.0),
                                                                    child: Text(
                                                                        'Confirmação',
                                                                        style: context
                                                                            .textTheme
                                                                            .bodyLarge!
                                                                            .copyWith(
                                                                          color:
                                                                              AppColors.globalBackground,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              20,
                                                                          letterSpacing:
                                                                              1.5,
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            12.0),
                                                                    child: Text(
                                                                        'Você confirma a assinatura de todos os documentos da operação' +
                                                                            ' KGPC nº 434343?',
                                                                        style: context
                                                                            .textTheme
                                                                            .labelSmall!
                                                                            .copyWith(color: AppColors.labelText)),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) => AlertDialog(
                                                                                  title: Column(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(12.0),
                                                                                        child: Text('Assinatura Digital confirmada com sucesso',
                                                                                            style: context.textTheme.bodyLarge!.copyWith(
                                                                                              color: AppColors.globalBackground,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontSize: 20,
                                                                                              letterSpacing: 1.5,
                                                                                            )),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(12.0),
                                                                                        child: Text(
                                                                                          'Quando sua operação possuir o numero de assinaturas necessarias, ela passará para o status de' + 'Assinada' + 'Você pode acompanhar o status das suas assinaturas clicando no botão abaixo.',
                                                                                          style: context.textTheme.labelSmall!.copyWith(color: AppColors.labelText),
                                                                                          textAlign: TextAlign.justify,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Expanded(
                                                                                              child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  Modular.to.pushNamed(AppRoutes.assinaturaDigitalRoute);
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  backgroundColor: AppColors.botaoEnvio,
                                                                                                ),
                                                                                                child: const Padding(
                                                                                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      'Acompanhar Assinaturas',
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  Modular.to.pushNamed(AppRoutes.assinaturaDigitalRoute);
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: const BorderSide(color: AppColors.botaoEnvio, width: 1))),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text('Fazer Nova Assinatura', style: context.textTheme.labelSmall!.copyWith(color: AppColors.botaoEnvio)),
                                                                                                  ),
                                                                                                )),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: AppColors.botaoEnvio,
                                                                            ),
                                                                            child:
                                                                                const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 8.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  'Confirmar',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: ElevatedButton(
                                                                            onPressed: () {},
                                                                            style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.white,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(4),
                                                                                side: const BorderSide(color: AppColors.botaoEnvio, width: 1),
                                                                              ),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text('CANCELAR', style: context.textTheme.labelSmall!.copyWith(color: AppColors.botaoEnvio)),
                                                                              ),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColors
                                                                  .botaoEnvio,
                                                        ),
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                'Assinar Dodumentos'),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          Modular.to.pushNamed(
                                                              AppRoutes
                                                                  .importarCertificadoRoute);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shadowColor: Colors
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
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                'Selecionar Certificado Digital',
                                                                style: context
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .botaoEnvio)),
                                                          ),
                                                        )),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'Certificados disponiveis:',
                                                      style: context
                                                          .textTheme.labelSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .labelText),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text("Assinar Operação")))
                          ],
                        );
                      },
                    ),
                    options: CarouselOptions(
                        showIndicator: true,
                        controller: carouselController,
                        scrollDirection: Axis.horizontal,
                        floatingIndicator: true,
                        slideIndicator: const CircularSlideIndicator(
                          currentIndicatorColor: AppColors.botaoEnvio,
                          alignment: Alignment.center,
                          indicatorBorderColor: AppColors.botaoEnvio,
                        )))
              ],
            ),
          )
        : Container();
  }
}

part of 'card_monitor_assinaturas.dart';

class _ExpansibleInfoCard extends StatefulWidget {
  final bool isVisible;
  final List<Assinante> assinantes;
  final bool assinarDocumento;

  const _ExpansibleInfoCard(
      {super.key,
      required this.isVisible,
      required this.assinantes,
      this.assinarDocumento = false});

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
    final ImportarCertificadoProvider certificadoProvider =
        Modular.get<ImportarCertificadoProvider>();
    return widget.isVisible
        ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(),
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
                                                  procurador.nomeProcurador !=
                                                          null
                                                      ? procurador
                                                          .nomeProcurador!
                                                          .replaceAll(
                                                              RegExp(
                                                                  r'[\[\],]'),
                                                              '')
                                                      : "",
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
                                                          color: AppColors.labelText),
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
                                                            .dataAssinatura !=
                                                        null
                                                    ? DateFormat("dd/MM/yyyy").format(DateTime.parse(dataAssinatura.dataAssinatura!))
                                                    : "",
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
                        Visibility(
                          visible: widget.assinarDocumento,
                          child: SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.7,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    certificadoProvider.listaCertificados =
                                        await certificadoProvider
                                            .listaCertificadosFuture();
                                    if (certificadoProvider
                                        .listaCertificados.isEmpty) {
                                      Modular.to.pushNamed(AppRoutes
                                          .importarCertificadoRoute);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            SelecionarCertificado(),
                                        useSafeArea: true,
                                      );
                                    }
                                  },
                                  child: Text("Assinar Operação"))),
                        )
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
                      currentIndicatorColor: AppColors.statusAzul,
                      alignment: Alignment.center,
                      indicatorBorderColor: AppColors.statusAzul,
                    )))
          ],
        )
        : Container();
  }
}

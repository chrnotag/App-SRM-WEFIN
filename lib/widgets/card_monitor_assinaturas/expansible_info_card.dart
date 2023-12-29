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
    final ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    bool isTemaSRM = themeProvider.temaSelecionado == TemaSelecionado.SRM;
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
                  items: assinantes
                      .expand((assinante) => assinante.informacoesAssinante.map(
                          (info) => _construirTelaInformacoesCarrossel(
                              assinante, info, certificadoProvider)))
                      .toList(),
                  options: CarouselOptions(
                    showIndicator: true,
                    controller: carouselController,
                    scrollDirection: Axis.horizontal,
                    floatingIndicator: false,
                    slideIndicator: CircularSlideIndicator(
                        padding: EdgeInsets.only(bottom: 30),
                        indicatorBorderColor:
                            Colors.grey.shade500.withAlpha(50),
                        currentIndicatorColor: context.primaryColor,
                        indicatorBackgroundColor:
                            context.primaryColor.withAlpha(80)),
                  ))
            ],
          )
        : Container();
  }

  Widget _construirTelaInformacoesCarrossel(
      Assinante assinante,
      InformacaoAssinante info,
      ImportarCertificadoProvider certificadoProvider) {
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: 500,
                  maxWidth: MediaQuery.of(context).size.width * 0.3),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Papéis',
                          style: context.textTheme.bodyMedium,
                        ),
                        ...info.papeis
                            .map((papel) => Text(
                                  papel.replaceAll(RegExp(r'[\[\],]'), ''),
                                  style: context.textTheme.bodySmall,
                                ))
                            .toList(),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Procurador',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          info.nomeProcurador ?? "",
                          style: context.textTheme.bodySmall,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: context.textTheme.bodyMedium,
                        ),
                        assinaturaProvider.traduzirStatusAssinatura(
                            info.statusAssinatura, context)
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assinante',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          assinante.nomeAssinante
                              .replaceAll(RegExp(r'[\[\],]'), ''),
                          style: context.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Documentos',
                        style: context.textTheme.bodyMedium,
                      ),
                      ...info.documentos
                          .map((doc) => Text(
                                doc.nome.replaceAll(RegExp(r'[\[\],]'), ''),
                                style: context.textTheme.bodySmall,
                              ))
                          .toList(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipo de Assinatura',
                          style: context.textTheme.bodyMedium,
                        ),
                        Text(
                          info.tipoAssinatura
                              .replaceAll(RegExp(r'[\[\],]'), ''),
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        info.dataAssinatura != null
                            ? DateFormat("dd/MM/yyyy")
                                .format(DateTime.parse(info.dataAssinatura!))
                            : "",
                        style: context.textTheme.bodySmall,
                      ),
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
              width: MediaQuery.of(context).size.width * 0.7,
              child: BotaoPadrao(
                  onPressed: () async {
                    certificadoProvider.listaCertificados =
                        await certificadoProvider.listaCertificadosFuture();
                    if (certificadoProvider.listaCertificados.isEmpty) {
                      Modular.to.pushNamed(AppRoutes.importarCertificadoRoute);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SelecionarCertificado(),
                        useSafeArea: true,
                      );
                    }
                  },
                  label: "Assinar Operação")),
        )
      ],
    );
  }
}

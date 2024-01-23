part of 'card_monitor_assinaturas.dart';

class _ExpansibleInfoCard extends StatefulWidget {
  final bool isVisible;
  final List<Assinante> assinantes;
  final bool assinarDocumento;
  final int codOperacao;

  const _ExpansibleInfoCard(
      {super.key,
      required this.isVisible,
      required this.assinantes,
      this.assinarDocumento = false,
      required this.codOperacao});

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
                        padding: EdgeInsets.only(bottom: 30.h),
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
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    bool filtroBotaoAssinar() {
      return assinante.informacoesAssinante.any((element) =>
          authProvider.dataUser!.identificadorUsuario ==
          element.identificadorAssinador);
    }

    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
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
                    height: 8.h,
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
                    height: 8.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        info.statusAssinatura,
                        style: context.textTheme.bodySmall!.copyWith(
                            color: assinaturaProvider
                                .corStatusAssinatura(info.statusAssinatura)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
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
            SizedBox(
              width: context.width * 0.3,
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
                    padding: EdgeInsets.symmetric(vertical: 8.h),
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
          visible: widget.assinarDocumento && filtroBotaoAssinar(),
          child: SizedBox(
              width: context.width * 0.7,
              child: BotaoPadrao(
                  onPressed: () async {
                    AssinaturaEletronicaProvider assEletronicaProvider =
                        Modular.get<AssinaturaEletronicaProvider>();
                    assEletronicaProvider.codOperacao = widget.codOperacao;
                    IniciarAssinaturaProvider iniciarAssinatura =
                        Modular.get<IniciarAssinaturaProvider>();
                    iniciarAssinatura.IniciarAssinatura(info, context);
                  },
                  label: "Assinar Operação")),
        )
      ],
    );
  }
}

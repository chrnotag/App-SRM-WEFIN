part of 'card_monitor_assinaturas.dart';

class _ExpansibleInfoCard extends StatefulWidget {
  final bool isVisible;
  final List<Assinante> assinantes;
  final bool assinarDocumento;
  final int codigoOperacao;

  const _ExpansibleInfoCard(
      {super.key,
      required this.isVisible,
      required this.assinantes,
      this.assinarDocumento = false,
      required this.codigoOperacao});

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
    final CertificadoProvider certificadoProvider =
        Modular.get<CertificadoProvider>();
    return widget.isVisible
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: SizedBox(
                  height: 300.h,
                  width: context.width,
                  child: FlutterCarousel(
                      items: assinantes
                          .expand((assinante) => assinante.informacoesAssinante
                              .map((info) => SingleChildScrollView(
                                    child: _construirTelaInformacoesCarrossel(
                                        assinante, info, certificadoProvider),
                                  )))
                          .toList(),
                      options: CarouselOptions(
                        showIndicator: true,
                        controller: carouselController,
                        scrollDirection: Axis.horizontal,
                        floatingIndicator: false,
                        slideIndicator: CircularSlideIndicator(
                            padding: EdgeInsets.only(bottom: 10.h),
                            indicatorBorderColor:
                            Colors.grey.shade500.withAlpha(50),
                            currentIndicatorColor: context.primaryColor,
                            indicatorBackgroundColor:
                                context.primaryColor.withAlpha(80)),
                      )),
                ),
              )
            ],
          )
        : Container();
  }

  Widget _construirTelaInformacoesCarrossel(
      Assinante assinante,
      InformacaoAssinante info,
      CertificadoProvider certificadoProvider) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    bool filtroBotaoAssinar() {
      return assinante.informacoesAssinante.any((element) =>
          authProvider.dataUser!.identificadorUsuario ==
          element.identificadorAssinador);
    }
    bool documentoAssinado = info.statusAssinatura.toLowerCase() == "assinado";
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        'Papéis',
                        style: context.textTheme.bodyMedium,
                      ),
                      ...info.papeis
                          .map(
                            (papel) => Text(
                              papel.replaceAll(RegExp(r'[\[\],]'), ''),
                              style: context.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: context.width * 0.3,
                            child: Text(
                              info.nomeProcurador ?? "",
                              style: context.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,

                            ),
                          ),
                          if(info.statusAssinatura.toLowerCase() == "assinado" && info.nomeProcurador != null)
                            Icon(Icons.check_circle, color: Colors.green,size: 15.r,)
                        ],
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
                      Row(
                        children: [
                          SizedBox(
                            width: documentoAssinado ? context.width * 0.2 : context.width * 0.3,
                            child: Text(
                              assinante.nomeAssinante
                                  .replaceAll(RegExp(r'[\[\],]'), ''),
                              style: context.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if(documentoAssinado)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Icon(Icons.check_circle, color: Colors.green,size: 15.r,),
                            )
                        ],
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
                          .map(
                            (doc) => Text(
                              doc.nome.replaceAll(RegExp(r'[\[\],]'), ''),
                              style: context.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
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
                            : "--/--/----",
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: context.width * 0.7,
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Visibility(
              visible: widget.assinarDocumento && filtroBotaoAssinar(),
              child: BotaoPadrao(
                  onPressed: () async  {
                    AssinaturaEletronicaProvider assinaturaEletronicaProvider =
                        Modular.get<AssinaturaEletronicaProvider>();
                    assinaturaEletronicaProvider.codigoOperacao = widget.codigoOperacao;
                    IniciarAssinaturaProvider iniciarAssinatura =
                        Modular.get<IniciarAssinaturaProvider>();
                    iniciarAssinatura.IniciarAssinatura(info, context);
                  },
                  label: "Assinar Operação"),
            ),
          ),
        )
      ],
    );
  }
}

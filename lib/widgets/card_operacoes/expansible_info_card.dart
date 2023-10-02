part of 'card_monitor_operacoes.dart';

class _ExpansibleInfoCard extends StatefulWidget {
  final bool isVisible;
  final List<OperacaoModel> operacao;

  const _ExpansibleInfoCard(
      {super.key, required this.isVisible, required this.operacao});

  @override
  State<_ExpansibleInfoCard> createState() => __ExpansibleInfoCardState();
}

class __ExpansibleInfoCardState extends State<_ExpansibleInfoCard> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int indicie = 0;

  @override
  Widget build(BuildContext context) {
    var operacoes = widget.operacao;
    final CarouselController carouselController = CarouselController();
    return Visibility(
      visible: widget.isVisible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(height: 1, color: AppColors.labelText),
          FlutterCarousel(
              items: List.generate(
                operacoes.length,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Papéis',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              if (operacoes.isNotEmpty)
                                for (var papel in operacoes[indicie].papeis!)
                                  Text(
                                    papel.replaceAll(RegExp(r'[\[\],]'), ''),
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
                                'Procurador',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              Text(
                                operacoes[indicie]
                                    .procurador!
                                    .replaceAll(RegExp(r'[\[\]]'), ''),
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
                                'Situação',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              Text(
                                operacoes[indicie]
                                    .situacao!
                                    .replaceAll(RegExp(r'[\[\]]'), ''),
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: operacoes[indicie].situacao! ==
                                            "Aprovada"
                                        ? AppColors.success
                                        : operacoes[indicie].situacao! ==
                                                "Pendente"
                                            ? AppColors.laranja
                                            : AppColors.error),
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
                                'Assinantes',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              if (operacoes[indicie].assinantes!.isNotEmpty)
                                for (var papel
                                    in operacoes[indicie].assinantes!)
                                  Text(
                                    papel.replaceAll(RegExp(r'[\[\]]'), ''),
                                    style: context.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Documentos',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              if (operacoes[indicie].documentos!.isNotEmpty)
                                for (var papel
                                    in operacoes[indicie].documentos!)
                                  Text(
                                    papel.replaceAll(RegExp(r'[\[\],]'), ''),
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
                                'Tipo de Assinatura',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              Text(
                                operacoes[indicie]
                                    .tipoAssinatura!
                                    .replaceAll(RegExp(r'[\[\]]'), ''),
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
                                'Data',
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.globalBackground),
                              ),
                              Text(
                                operacoes[indicie]
                                    .data!
                                    .replaceAll(RegExp(r'[\[\]]'), ''),
                                style: context.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
    );
  }
}

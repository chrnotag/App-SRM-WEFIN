part of 'card_monitor_operacoes.dart';

class _ExpansibleInfoCard extends StatefulWidget {
  final bool isVisible;
  final OperacaoModel operacao;

  const _ExpansibleInfoCard(
      {super.key, required this.isVisible, required this.operacao});

  @override
  State<_ExpansibleInfoCard> createState() => __ExpansibleInfoCardState();
}

class __ExpansibleInfoCardState extends State<_ExpansibleInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Visibility(
        visible: widget.isVisible,
        child: IntrinsicHeight(
          child: Column(
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Papéis',
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.globalBackground),
                            ),
                            if (widget.operacao.papeis!.isNotEmpty)
                              for (var papel in widget.operacao.papeis!)
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
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.globalBackground),
                            ),
                            Text(
                              widget.operacao.procurador!
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
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.globalBackground),
                            ),
                            Text(
                              widget.operacao.situacao!
                                  .replaceAll(RegExp(r'[\[\]]'), ''),
                              style: context.textTheme.bodySmall!.copyWith(
                                  color: widget.operacao.situacao! == "Aprovada"
                                      ? AppColors.success
                                      : widget.operacao.situacao! == "Pendente"
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
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.globalBackground),
                            ),
                            if (widget.operacao.assinantes!.isNotEmpty)
                              for (var papel in widget.operacao.assinantes!)
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
                              if (widget.operacao.documentos!.isNotEmpty)
                                for (var papel in widget.operacao.documentos!)
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
                                widget.operacao.tipoAssinatura!
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
                                widget.operacao.data!
                                    .replaceAll(RegExp(r'[\[\]]'), ''),
                                style: context.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

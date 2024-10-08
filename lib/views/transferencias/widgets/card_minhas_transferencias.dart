part of '../transferencias_screen.dart';

class _CardMinhasTransferencias extends StatelessWidget {
  final String favorecido;
  final String documento;
  final DateTime data;
  final StatusMinhasTransferenciasEnum status;
  final String? codigoTransacao;
  const _CardMinhasTransferencias({super.key, required this.favorecido, required this.documento, required this.data, this.codigoTransacao, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        // height: statusTed == TedTerceirosEnum.PARA_APROVACAO || statusTed == TedTerceirosEnum.PAGO ? 300.h : 250.h,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: context.bordaCardColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemCardTed(title: 'Favorecido', content: favorecido),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: ItemCardTed(
                    title: 'CPF/CNPJ',
                    content: documento.formatarDocumento(),
                  ),
                ),
                ItemCardTed(
                  title: 'Data',
                  content: '${data.formatarDataBR}',
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status'),
                      Container(
                        decoration: BoxDecoration(
                          color: status.corStatus,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          child: Text(
                            status.status,
                            style: context.textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: status.mostrarComprovante,
                  child: Column(
                    children: [
                      Divider(thickness: 0.1,),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () async {
                                  OverlayApp.iniciaOverlay(context);
                                  final result = await TedTerceirosImpl.downloadComprovante(codigoTransacao!);
                                  OverlayApp.terminaOverlay();
                                  if (result.error != null) {
                                    Fluttertoast.showToast(
                                        msg:
                                        'Houve um erro ao tentar obter o comprovante: ${result.error.mensagem}');
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VisualizarPdfTed(),
                                        ));
                                  }
                                },
                                child: Text(
                                  'Ver Comprovante',
                                  style: context.textTheme.displaySmall!.copyWith(
                                      color: context.primaryColor,
                                      fontWeight: FontWeight.w900),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

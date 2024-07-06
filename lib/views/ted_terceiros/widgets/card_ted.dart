part of '../lista_ted_screen/lista_teds_aprovacao_screen.dart';

class _CardTedTerceiros extends StatelessWidget {
  final Transferencia transferencia;
  const _CardTedTerceiros({super.key, required this.transferencia});

  @override
  Widget build(BuildContext context) {
    print('cpodigo transferencia: ${transferencia.codigo}');
    final statusTed = TedTerceirosEnum.fromStatus(transferencia.statusTransferencia);
    Widget? botoesCard(TedTerceirosEnum statusTed){
      switch(statusTed){
        case TedTerceirosEnum.PAGO:
          return BotaoComprovanteTedTerceiros(codigoTransacao: transferencia.codigo,);
        case TedTerceirosEnum.PARA_APROVACAO:
          return BotoesAprovarTedTerceiros(codigoTransferencia: transferencia.codigo,);
        default:
          return Container();
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: statusTed == TedTerceirosEnum.PARA_APROVACAO || statusTed == TedTerceirosEnum.PAGO ? 300.h : 250.h,
        child: Card(
          elevation: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ItemCardTed(
                    title: 'Favorecido', content: transferencia.nomeFavorecido),
                _ItemCardTed(title: 'CPF/CNPJ', cnpjFormatter: Text('${transferencia.identificadorFavorecido}',)),
                _ItemCardTed(title: 'Valor', content: double.parse(transferencia.valor).toBRL),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status'),
                    Container(
                      decoration: BoxDecoration(
                        color: statusTed.corFundo,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.r),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        child: Text(
                          statusTed.status,
                          style: context.textTheme.bodyLarge!.copyWith(
                              color: statusTed.corTexto,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [botoesCard(statusTed) ?? Container()],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

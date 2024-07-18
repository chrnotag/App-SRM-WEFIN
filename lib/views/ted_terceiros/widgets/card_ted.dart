part of '../lista_teds_aprovacao_screen.dart';

class _CardTedTerceiros extends StatelessWidget {
  final Transferencia transferencia;
  const _CardTedTerceiros({super.key, required this.transferencia});

  @override
  Widget build(BuildContext context) {
    print('cpodigo transferencia: ${transferencia.codigo}');
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
        height: transferencia.statusTransferencia == TedTerceirosEnum.PARA_APROVACAO || transferencia.statusTransferencia == TedTerceirosEnum.PAGO ? 300.h : 250.h,
        child: Card(
          elevation: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemCardTed(
                    title: 'Favorecido', content: transferencia.nomeFavorecido),
                ItemCardTed(title: 'CPF/CNPJ', cnpjFormatter: Text('${transferencia.identificadorFavorecido}',)),
                ItemCardTed(title: 'Valor', content: double.parse(transferencia.valor).toBRL),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status'),
                    Container(
                      decoration: BoxDecoration(
                        color: transferencia.statusTransferencia.corFundo,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.r),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        child: Text(
                          transferencia.statusTransferencia.status,
                          style: context.textTheme.bodyLarge!.copyWith(
                              color: transferencia.statusTransferencia.corTexto,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [botoesCard(transferencia.statusTransferencia) ?? Container()],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

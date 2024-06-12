part of '../tela_extrato.dart';

class _ItemListaOperacao extends StatelessWidget {
  final TipoTED tipoTED;
  final String descricao;
  final double valorOperacao;
  final String codigoTransacao;
  final String dataComprovante;

  const _ItemListaOperacao({
    super.key,
    required this.tipoTED,
    required this.descricao,
    required this.valorOperacao,
    required this.codigoTransacao,
    required this.dataComprovante,
  });

  @override
  Widget build(BuildContext context) {
    final temComprovante = !(tipoTED == TipoTED.DEVOLUCAO_TED ||
        tipoTED == TipoTED.TARIFA_TED);
    return ListTile(
      onTap: temComprovante ? () {
        Modular.to.pushNamed(AppRoutes.visualizarComprovanteTEDScreenRoute +
            '/$codigoTransacao' +
            '/$dataComprovante');
      } : () {Fluttertoast.showToast(msg: 'Não há comprovante disponível para tarifas e/ou devoluções');},
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(Assets.dolarIconList),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tipoTED.stringTED),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: tipoTED.corFundo),
                          child: Text(
                            FormatarDinheiro.BR(valorOperacao),
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: tipoTED.corTexto),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: temComprovante ? Icon(
                            Icons.arrow_forward_ios,
                            color: context.primaryColor,
                          ) : Padding(padding: EdgeInsets.only(left: 16.w)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.width * 0.75, child: Text(descricao)),
            ],
          )
        ],
      ),
    );
  }
}

part of '../tela_extrato.dart';

class _ItemListaOperacao extends StatelessWidget {
  final TipoTED tipoTED;
  final String descricao;
  final double valorOperacao;

  const _ItemListaOperacao({
    super.key,
    required this.tipoTED,
    required this.descricao,
    required this.valorOperacao,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                width: 320.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tipoTED.stringTED),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: tipoTED.cor),
                      child: Text(
                        FormatarDinheiro.BR(valorOperacao),
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: tipoTED == TipoTED.ENVIO_TED
                                ? Color(0XFFe6492d)
                                : Color(0XFF0e6dfe)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: context.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: context.width * 0.7,
                  child: Text(descricao)),
            ],
          )
        ],
      ),
    );
  }
}

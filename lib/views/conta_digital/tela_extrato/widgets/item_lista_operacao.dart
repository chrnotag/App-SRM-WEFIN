part of '../tela_extrato.dart';

class _ItemListaOperacao extends StatelessWidget {
  final TipoTED tipoTED;
  final String nome;
  final double valorOperacao;

  const _ItemListaOperacao({
    super.key,
    required this.tipoTED,
    required this.nome,
    required this.valorOperacao,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Image.asset(Assets.dolarIconList),
          Column(
            children: [
              Row(
                children: [
                  Text(tipoTED.stringTED),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: tipoTED.cor),
                    child: Text(FormatarDinheiro.BR(valorOperacao)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.primaryColor,
                  )
                ],
              ),
              Text(nome),
            ],
          )
        ],
      ),
    );
  }
}

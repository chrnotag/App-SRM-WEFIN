part of 'botoes_para_aprovacao.dart';

class _AlertAprovacaoTed extends StatelessWidget {
  final AprovarTedEnum aprovacao;
  final int codigoTransferencia;

  const _AlertAprovacaoTed(
      {super.key, required this.aprovacao, required this.codigoTransferencia});

  @override
  Widget build(BuildContext context) {
    final ambiente = Modular.get<Environment>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      icon: SvgPicture.asset(ambiente.alerta_icone),
      title: SizedBox(
        height: context.height * 0.25,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'TED PARA TERCEIROS',
                  style: context.textTheme.displaySmall!.copyWith(
                      color: context.labelTextColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Tem certeza que deseja ${aprovacao.name.toLowerCase()}\n essa operação?',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BotaoPadrao(
                    label: 'Não',
                    filled: false,
                    onPressed: () {
                      Modular.to.pop();
                    }),
                BotaoPadrao(
                    label: 'Sim',
                    onPressed: () async {
                      print('testando: $aprovacao, $codigoTransferencia');
                      OverlayApp.iniciaOverlay(context);
                      final result = await TedTerceirosImpl.aprovarOuRecusar(
                          aprovacao, codigoTransferencia);
                      OverlayApp.terminaOverlay();
                     if(result.error != null){
                       Fluttertoast.showToast(msg: 'Houve um erro ao processar a operação: ${result.error.mensagem}');
                     }else{
                       showDialog(
                         context: context,
                         builder: (context) =>
                             _AlertConcluidoAprovacaoTed(aprovacao: aprovacao),
                       );
                     }
                     Modular.get<TedTerceirosProvider>().carregarDados();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AlertConcluidoAprovacaoTed extends StatelessWidget {
  final AprovarTedEnum aprovacao;

  const _AlertConcluidoAprovacaoTed({super.key, required this.aprovacao});

  @override
  Widget build(BuildContext context) {
    final ambiente = Modular.get<Environment>();
    return AlertDialog(
      icon: SvgPicture.asset(ambiente.check_icone),
      title: SizedBox(
        height: context.height * 0.25,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'TED PARA TERCEIROS',
                  style: context.textTheme.displaySmall!.copyWith(
                      color: context.labelTextColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'A operação TED para Terceiros foi ${aprovacao == AprovarTedEnum.APROVAR ? 'aprovada' : 'recusada'} com sucesso!',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            BotaoPadrao(
                label: 'Fechar',
                onPressed: () {
                  Modular.to.pop();
                  Modular.to.pop();
                })
          ],
        ),
      ),
    );
  }
}

part of 'transferencias_screen.dart';

class _MinhasTransferencias extends StatefulWidget {
  const _MinhasTransferencias({super.key});

  @override
  State<_MinhasTransferencias> createState() => _MinhasTransferenciasState();
}

class _MinhasTransferenciasState extends State<_MinhasTransferencias> {
  @override
  void initState() {
    final provider = Modular.get<SolicitacoesTedProvider>();
    final contaProvider = Modular.get<ContaDigitalProvider>();
    provider.futureSolicitacoesTed = provider
        .carregarSolicitacoesTed(contaProvider.dadosContaDigital!.conta);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final solicitacoesProvider = context.watch<SolicitacoesTedProvider>();
    return FutureBuilder(
        future: solicitacoesProvider.futureSolcitacoesTed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (solicitacoesProvider.solicitacoesTed!.itens.length <= 0) {
            return MensagemTelaVazia(
                titulo: 'Não há trasnferencias',
                mensagem: 'Sem transferencias para acompanhamento');
          }
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: solicitacoesProvider.solicitacoesTed!.itens.length,
                itemBuilder: (context, index) => _CardMinhasTransferencias(
                    favorecido: solicitacoesProvider
                        .solicitacoesTed!.itens[index].beneficiario.nome,
                    documento: solicitacoesProvider
                        .solicitacoesTed!.itens[index].beneficiario.documento,
                    data: solicitacoesProvider
                        .solicitacoesTed!.itens[index].dataCriacao,
                    codigoTransacao: solicitacoesProvider
                        .solicitacoesTed!.itens[index].identificador,
                    status: StatusMinhasTransferenciasEnum.values.firstWhere(
                      (status) {
                        print('${solicitacoesProvider.solicitacoesTed!.itens[index].dataCriacao}');
                        return status.name ==
                            solicitacoesProvider
                                .solicitacoesTed!.itens[index].status.codigo;
                      },
                    )),
              ),
            ),
          ]);
        });
  }
}

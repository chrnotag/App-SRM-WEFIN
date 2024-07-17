part of 'transferencias_screen.dart';

class _TransferenciasTed extends StatefulWidget {
  const _TransferenciasTed({super.key});

  @override
  State<_TransferenciasTed> createState() => _TransferenciasTedState();
}

class _TransferenciasTedState extends State<_TransferenciasTed> {
  final TextEditingController controllerAgencia = TextEditingController();
  final TextEditingController controllerConta = TextEditingController();
  final TextEditingController controllerValor = TextEditingController();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerDocumento = TextEditingController();

  @override
  void initState() {
    super.initState();
    final solicitarTedProvider = Modular.get<SolicitarTedProvider>();
    solicitarTedProvider.futureDados = solicitarTedProvider.carregarDados();

    controllerAgencia.addListener(_updateButtonState);
    controllerConta.addListener(_updateButtonState);
    controllerValor.addListener(_updateButtonState);
    controllerNome.addListener(_updateButtonState);
    controllerDocumento.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    controllerAgencia.dispose();
    controllerConta.dispose();
    controllerValor.dispose();
    controllerNome.dispose();
    controllerDocumento.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
  }

  bool _isFormValid(SolicitarTedProvider provider) {
    return controllerDocumento.text.isNotEmpty &&
        controllerNome.text.isNotEmpty &&
        controllerValor.text.isNotEmpty &&
        controllerConta.text.isNotEmpty &&
        controllerAgencia.text.isNotEmpty &&
        provider.tipoContaSelecionada.isNotEmpty &&
        provider.bancoSelecionado != null;
  }

  @override
  Widget build(BuildContext context) {
    final solicitarTedProvider = Modular.get<SolicitarTedProvider>();

    return FutureBuilder(
      future: solicitarTedProvider.futureDados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transferência TED',
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Preencha abaixo os dados do favorecido',
                    style: context.textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CampoTexto(
                          tituloCampo: 'Valor',
                          obrigatorio: true,
                          campoMonetario: true,
                          formatos: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter()
                          ],
                          hint: 'R\$ 0,00',
                          controller: controllerValor,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Instituição Bancária',
                              style: context.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                                text: ' *',
                                style: context.textTheme.bodyLarge!.copyWith(
                                    color: context.errorColor,
                                    fontWeight: FontWeight.w600))
                          ]),
                        ),
                        Container(
                          width: context.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: context.labelTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: DropdownButton(
                              style: context.textTheme.bodyLarge,
                              underline: Container(),
                              isExpanded: true,
                              value: solicitarTedProvider.bancoSelecionado,
                              selectedItemBuilder: (context) =>
                                  solicitarTedProvider.listaBancos
                                      .map((e) => DropdownMenuItem<BancosModel>(
                                            value: e,
                                            child: Text(
                                              '${e.codigo} - ${e.nome}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                              items: solicitarTedProvider.listaBancos
                                  .map((e) => DropdownMenuItem<BancosModel>(
                                        value: e,
                                        child: Column(
                                          children: [
                                            Text(
                                              '${e.codigo} - ${e.nome}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Divider(
                                              thickness: 0.1,
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  solicitarTedProvider.bancoSelecionado = value;
                                });
                              },
                              iconEnabledColor: context.primaryColor,
                              iconDisabledColor: context.labelTextColor,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              hint: Text(
                                'Selecione a instituição',
                                style: context.textTheme.bodyLarge!
                                    .copyWith(color: context.labelTextColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _CampoTexto(
                          tituloCampo: 'Agência',
                          hint: '0000',
                          obrigatorio: true,
                          controller: controllerAgencia,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _CampoTexto(
                          tituloCampo: 'Conta',
                          obrigatorio: true,
                          hint: '0000000-00',
                          controller: controllerConta,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Tipo Conta',
                              style: context.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                                text: ' *',
                                style: context.textTheme.bodyLarge!.copyWith(
                                    color: context.errorColor,
                                    fontWeight: FontWeight.w600))
                          ]),
                        ),
                        Container(
                          width: context.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: context.labelTextColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: DropdownButton(
                              style: context.textTheme.bodyLarge,
                              underline: Container(),
                              isExpanded: true,
                              value: solicitarTedProvider.tipoContaSelecionada,
                              items: TipoContaEnum.values
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.tipoConta,
                                        child: Text(e.tipoConta),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  print('valor: ${TipoContaEnum.traduzir(value!)}');
                                  solicitarTedProvider.tipoContaSelecionada =
                                      value!;
                                });
                              },
                              iconEnabledColor: context.primaryColor,
                              iconDisabledColor: context.labelTextColor,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              hint: Text(
                                'Ex: Corrente',
                                style: context.textTheme.bodyLarge!
                                    .copyWith(color: context.labelTextColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(height: 16.h),
                  _CampoTexto(
                    tituloCampo: 'Nome completo',
                    hint: 'Nome de quem vai receber',
                    obrigatorio: true,
                    controller: controllerNome,
                  ),
                  SizedBox(height: 16.h),
                  _CampoTexto(
                    tituloCampo: 'CPF/CNPJ',
                    hint: 'CPF / CNPJ de quem irá receber',
                    obrigatorio: true,
                    formatos: [CpfCnpjInputFormatter()],
                    controller: controllerDocumento,
                  ),
                  SizedBox(height: 16.h),
                  BotaoPadrao(
                      label: 'Solicitar Transferencia',
                      onPressed: _isFormValid(solicitarTedProvider)
                          ? () async {
                              solicitarTedProvider.agencia =
                                  UtilBrasilFields.removeCaracteres(controllerAgencia.text);
                              solicitarTedProvider.conta = UtilBrasilFields.removeCaracteres(controllerConta.text);
                              solicitarTedProvider.nome = UtilBrasilFields.removeCaracteres(controllerNome.text);
                              solicitarTedProvider.valor = UtilBrasilFields.converterMoedaParaDouble(controllerValor.text);
                              solicitarTedProvider.documento =
                                  UtilBrasilFields.removeCaracteres(controllerDocumento.text);
                              OverlayApp.iniciaOverlay(context);
                              final response =
                                  await solicitarTedProvider.enviarToken();
                              OverlayApp.terminaOverlay();
                              print(response);
                              if (response) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _AlertCodigoVerificacao());
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialogGenerico(
                                      title: 'Erro na requisição',
                                      msg: 'Erro durante a confirmação',
                                      onPressed: () => Modular.to.pop()),
                                );
                              }
                            }
                          : null),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

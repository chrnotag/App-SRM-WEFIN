part of 'transferencias_screen.dart';

class _TransferenciasTed extends StatefulWidget {
  const _TransferenciasTed({super.key});

  @override
  State<_TransferenciasTed> createState() => _TransferenciasTedState();
}

class _TransferenciasTedState extends State<_TransferenciasTed> {
  final _formKey = GlobalKey<FormState>();
  final solicitarTedProvider = Modular.get<SolicitarTedProvider>();

  @override
  void initState() {
    super.initState();
    solicitarTedProvider.futureDados = solicitarTedProvider.carregarDados();

    solicitarTedProvider.controllerAgencia.addListener(_updateButtonState);
    solicitarTedProvider.controllerConta.addListener(_updateButtonState);
    solicitarTedProvider.controllerValor.addListener(_updateButtonState);
    solicitarTedProvider.controllerNome.addListener(_updateButtonState);
    solicitarTedProvider.controllerIdBeneficiario
        .addListener(_updateButtonState);
  }

  @override
  void dispose() {
    solicitarTedProvider.limparControladores();
    final provider = Modular.get<SolicitarTedProvider>();
    provider.bancoSelecionado = null;
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
  }

  bool _isFormValid(SolicitarTedProvider provider) {
    return solicitarTedProvider.controllerIdBeneficiario.text.isNotEmpty &&
        solicitarTedProvider.controllerNome.text.isNotEmpty &&
        solicitarTedProvider.controllerValor.text.isNotEmpty &&
        solicitarTedProvider.controllerConta.text.isNotEmpty &&
        solicitarTedProvider.controllerAgencia.text.isNotEmpty &&
        provider.tipoContaSelecionada.isNotEmpty &&
        provider.bancoSelecionado != null;
  }

  @override
  Widget build(BuildContext context) {
    final solicitarTedProvider = context.watch<SolicitarTedProvider>();

    return FutureBuilder(
      future: solicitarTedProvider.futureDados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else {
          final favoritoProvider = Modular.get<BeneficiariosRecentesProvider>();
          return SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                    visible: favoritoProvider.listaBeneficiarios.isNotEmpty,
                    child: const _ListaFavoritos()),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  child: Form(
                    key: _formKey,
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
                                validator:
                                    Validatorless.required('Campo obrigatório'),
                                tipoTeclado: TextInputType.number,
                                formatos: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CentavosInputFormatter()
                                ],
                                hint: 'R\$ 0,00',
                                controller:
                                    solicitarTedProvider.controllerValor,
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
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: context.errorColor,
                                              fontWeight: FontWeight.w600))
                                ]),
                              ),
                              Container(
                                width: context.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: context.labelTextColor),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: BancoDropdown(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _CampoTexto(
                                tituloCampo: 'Agência',
                                hint: '0000',
                                obrigatorio: true,
                                tipoTeclado: TextInputType.number,
                                validator:
                                    Validatorless.required('Campo obrigatório'),
                                formatos: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller:
                                    solicitarTedProvider.controllerAgencia,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: _CampoTexto(
                                tituloCampo: 'Conta e Digito',
                                obrigatorio: true,
                                campoConta: true,
                                hint: '00000-0',
                                tipoTeclado: TextInputType.number,
                                validator:
                                    Validatorless.required('Campo obrigatório'),
                                formatos: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller:
                                    solicitarTedProvider.controllerConta,
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
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: context.errorColor,
                                              fontWeight: FontWeight.w600))
                                ]),
                              ),
                              Container(
                                width: context.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: context.labelTextColor),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: DropdownButton(
                                    style: context.textTheme.bodyLarge,
                                    underline: Container(),
                                    isExpanded: true,
                                    value: solicitarTedProvider
                                        .tipoContaSelecionada,
                                    items: TipoContaEnum.values
                                        .map((e) => DropdownMenuItem<String>(
                                              value: e.tipoConta,
                                              child: Text(e.tipoConta),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        print(
                                            'valor: ${TipoContaEnum.traduzir(value!)}');
                                        solicitarTedProvider
                                            .tipoContaSelecionada = value;
                                      });
                                    },
                                    iconEnabledColor: context.primaryColor,
                                    iconDisabledColor: context.labelTextColor,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint: Text(
                                      'Ex: Corrente',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: context.labelTextColor),
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
                          validator:
                              Validatorless.required('Campo obrigatório'),
                          controller: solicitarTedProvider.controllerNome,
                        ),
                        SizedBox(height: 16.h),
                        _CampoTexto(
                          tituloCampo: 'CPF/CNPJ',
                          hint: 'CPF / CNPJ de quem irá receber',
                          obrigatorio: true,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            if (solicitarTedProvider
                                    .controllerIdBeneficiario.text.length >
                                14)
                              Validatorless.cnpj('CPNJ inválido'),
                            if (solicitarTedProvider
                                    .controllerIdBeneficiario.text.length <=
                                14)
                              Validatorless.cpf('CPF inválido'),
                          ]),
                          formatos: [CpfCnpjInputFormatter()],
                          controller:
                              solicitarTedProvider.controllerIdBeneficiario,
                        ),
                        SizedBox(height: 16.h),
                        BotaoPadrao(
                            label: 'Solicitar Transferencia',
                            onPressed: _isFormValid(solicitarTedProvider)
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      solicitarTedProvider.agencia =
                                          UtilBrasilFields.removeCaracteres(
                                              solicitarTedProvider
                                                  .controllerAgencia.text);
                                      solicitarTedProvider.conta =
                                          UtilBrasilFields.removeCaracteres(
                                              solicitarTedProvider
                                                  .controllerConta.text
                                                  .replaceAll('-', ''));
                                      solicitarTedProvider.nome =
                                          solicitarTedProvider
                                              .controllerNome.text;
                                      solicitarTedProvider.valor =
                                          UtilBrasilFields
                                              .converterMoedaParaDouble(
                                                  solicitarTedProvider
                                                      .controllerValor.text);
                                      solicitarTedProvider
                                              .identificadorBeneficiario =
                                          UtilBrasilFields.removeCaracteres(
                                              solicitarTedProvider
                                                  .controllerIdBeneficiario
                                                  .text);
                                      OverlayApp.iniciaOverlay(context);
                                      final response =
                                          await solicitarTedProvider
                                              .enviarToken();
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
                                          builder: (context) =>
                                              AlertDialogGenerico(
                                                  title: 'Erro na requisição',
                                                  msg:
                                                      'Erro durante a confirmação',
                                                  onPressed: () =>
                                                      Modular.to.pop()),
                                        );
                                      }
                                    }
                                  }
                                : null),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

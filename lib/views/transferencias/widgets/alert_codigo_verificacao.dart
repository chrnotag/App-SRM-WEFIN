part of '../transferencias_screen.dart';

class _AlertCodigoVerificacao extends StatefulWidget {
  const _AlertCodigoVerificacao({super.key});

  @override
  State<_AlertCodigoVerificacao> createState() =>
      _AlertCodigoVerificacaoState();
}

class _AlertCodigoVerificacaoState extends State<_AlertCodigoVerificacao> {
  final provider = Modular.get<SolicitarTedProvider>();
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void _onLastFieldFilled() async {
    OverlayApp.iniciaOverlay(context);
    final response =
        await provider.solicitarTed(provider.parametroSolicitarTed);
    Modular.to.pop();
    if (response.error == null) {
      OverlayApp.terminaOverlay();
      showDialog(
        context: context,
        builder: (context) => _AlertTransferenciaFeita(),
      );
    } else {
      OverlayApp.terminaOverlay();
      showDialog(
        context: context,
        builder: (context) => AlertDialogGenerico(
            title: 'Erro na requisição',
            msg: '${response.error.erros}',
            onPressed: () => Modular.to.pop()),
      );
    }
  }

  int _contador = 60;
  bool _exibirMensagemTimer = false;

  String _mensagemReenviarCodigo() {
    if (_exibirMensagemTimer) {
      return 'Toque aqui para reinviar o codigo.';
    } else {
      return 'Toque aqui para reinviar em 00:${_contador}';
    }
  }

  Future<void> timerNovaMensagem() async {
    final timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (_contador > 0) {
        setState(() {
          _contador--;
        });
      } else {
        t.cancel();
        setState(() {
          _exibirMensagemTimer = true;
        });
        _contador = 60;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timerNovaMensagem();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      titlePadding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 16.w),
      title: Column(
        children: [
          Text(
            'Código de Verificação',
            style: context.textTheme.displaySmall!
                .copyWith(color: SRMColors.textBodyColor),
          ),
          Text(
            'Enviamos um código de verificação para o seu WhatsApp ${provider.respostaToken!.celular}',
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return _CampoTextoCodigo(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      provider.atualizarCodigo(value, index);
                    } else {
                      provider.deletarCodigo(index);
                    }
                  },
                  nextFocusNode: index < 5 ? _focusNodes[index + 1] : null,
                  prevFocusNode: index > 0 ? _focusNodes[index - 1] : null,
                  onFilled: index == 5 ? _onLastFieldFilled : null,
                );
              }),
            ),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Não recebeu o código no seu WhatsApp?\n',
                  style: context.textTheme.bodyLarge),
              TextSpan(
                  text: _mensagemReenviarCodigo(),
                  style: context.textTheme.bodyLarge!.copyWith(
                      color: _exibirMensagemTimer
                          ? context.primaryColor
                          : context.labelTextColor,
                      fontWeight: FontWeight.w900),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (_exibirMensagemTimer) {
                        OverlayApp.iniciaOverlay(context);
                        final response = await provider.enviarToken();
                        OverlayApp.terminaOverlay();
                      }
                    }),
            ]),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

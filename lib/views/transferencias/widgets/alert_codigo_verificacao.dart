part of '../transferencias_screen.dart';

class _AlertCodigoVerificacao extends StatefulWidget {
  const _AlertCodigoVerificacao({super.key});

  @override
  State<_AlertCodigoVerificacao> createState() =>
      _AlertCodigoVerificacaoState();
}

class _AlertCodigoVerificacaoState extends State<_AlertCodigoVerificacao> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void _onLastFieldFilled() {
    Modular.to.pop();
showDialog(context: context, builder: (context) => _AlertTransferenciaFeita(),);
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
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: SRMColors.textBodyColor),
          ),
          Text(
            'Enviamos um código de verificação para o seu WhatsApp (61) **** 0220',
            style: Theme.of(context).textTheme.bodyLarge,
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
                  nextFocusNode: index < 5 ? _focusNodes[index + 1] : null,
                  prevFocusNode: index > 0 ? _focusNodes[index - 1] : null,
                  onFilled: index == 5 ? _onLastFieldFilled : null,
                );
              }),
            ),
          ),
          RichText(text: TextSpan(children: [
            TextSpan(text: 'Não recebeu o código no seu WhatsApp?\n', style: context.textTheme.bodyLarge),
            TextSpan(text: 'Clique aqui para reinviar.', style: context.textTheme.bodyLarge!.copyWith(color: context.primaryColor, fontWeight: FontWeight.w900)),
          ]), textAlign: TextAlign.center,)
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

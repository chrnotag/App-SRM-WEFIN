import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';

import '../../core/providers/fluxo_assinatura_provider/assinatura_eletronica/iniciar_assinatura_eletronica_impl.dart';
import '../../models/fluxo_assinatura_model/iniciar_assinatura_eletronica/iniciar_assinatura_eletronica_model.dart';
import '../loader_widget.dart';
import '../wefin_patterns/wefin_default_button.dart';

class ConfirmarAssinaturaDialog extends StatefulWidget {
  final InformacaoAssinante assinante;
  const ConfirmarAssinaturaDialog({super.key, required this.assinante});

  @override
  State<ConfirmarAssinaturaDialog> createState() =>
      _ConfirmarAssinaturaDialogState();
}

class _ConfirmarAssinaturaDialogState extends State<ConfirmarAssinaturaDialog> {
  final assinaturaProvider = Modular.get<AssinaturaEletronicaProvider>();
  @override
  Widget build(BuildContext context) {
    final _overlayLoader = OverlayEntry(
      builder: (context) => const Material(
        color: Colors.transparent,
        child: Loader(),
      ),
    );
    final assinaturaProvider = Modular.get<AssinaturaProvider>();
    final assinaturaEletronicaProvider = Modular.get<AssinaturaEletronicaProvider>();
    return AlertDialog(
      icon: Icon(
        LineIcons.exclamationCircle,
        color: context.focusColor,
        size: 50,
      ),
      title: Column(
        children: [
          Text(
            'Você confirma a assinatura de todos os documentos da operação ${assinaturaProvider.assinaturaSelecionada!.siglaProduto} nº${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: BotaoPadrao(
                label: 'Confirmar',
                onPressed: () async {
                  Overlay.of(context).insert(_overlayLoader);
                  final response = await IniciarAssinaturaEletronicaImpl(
                          codigoOperacaoModel: IniciarAssinaturaEletronicaModel(
                              codigoOperacao: assinaturaProvider.assinaturaSelecionada!.codigoOperacao))
                      .iniciarAssinaturaEletronica();
                  if (response.error != null) {
                    _overlayLoader.remove();
                    Fluttertoast.showToast(
                        msg:
                            'Erro ao iniciar assinatura, tente novamente mais tarde. ${response.error.mensagem}');
                  } else {
                    _overlayLoader.remove();
                    Modular.to.pop();
                    assinaturaEletronicaProvider.informarCodigoEmail(context);
                  }
                }),
          ),
          BotaoPadrao(
              label: 'Cancelar',
              filled: false,
              onPressed: () {
                Modular.to.pop();
              })
        ],
      ),
    );
  }
}

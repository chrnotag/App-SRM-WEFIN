// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_impl.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/main.dart';
import 'package:modular_study/models/fluxo_assinatura_model/assinatura_eletronica/assinatura_eletronica_model.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

class AssinaturaEletronicaProvider extends ChangeNotifier {
  AssinaturaEletronicaModel? _assinaturaEletronicaModel;

  AssinaturaEletronicaModel? get assinaturaEletronica =>
      _assinaturaEletronicaModel;

  set assinaturaEletronica(
      AssinaturaEletronicaModel? assinaturaEletronicaModel) {
    _assinaturaEletronicaModel = assinaturaEletronicaModel;
    notifyListeners();
  }

  Future<Geolocalizacao?> _pegarGeolocalizacao() async {
    final posicao = await Geolocator.getCurrentPosition();

    return Geolocalizacao(
        latitude: posicao.latitude.toString(),
        longitude: posicao.longitude.toString(),
        precisao: posicao.accuracy.toString());
  }

  bool isErroAssinatura = false;
  int contador = 0;

  Future<void> _finalizarAssinaturaDigital(List<Documento> documentos) async {
    for (var doc in documentos) {
      showDialog(
        context: myNavigatorKey.currentState!.context,
        builder: (context) => _informarCodigoEmail(doc),
      );
      if (isErroAssinatura) {
        break;
      }
      contador++;
      if (contador == documentos.length) {
        showDialog(
          context: myNavigatorKey.currentState!.context,
          builder: (context) => _operacaoAssinada(),
        );
      }
    }
  }

  Widget _informarCodigoEmail(Documento documento) {
    TextEditingController codigoEmail = TextEditingController();
    return AlertDialog(
      icon: Icon(
        LineIcons.exclamationCircle,
        color: Colors.yellow.shade700,
      ),
      title: Column(
        children: [
          Text(
              'Por favor, informe o codigo recebido em seu email para assinar o documento ${documento.nome}'),
          TextField(
            controller: codigoEmail,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(6.r))),
                labelText: 'Informe o codigo',
                hintText: 'Informe o codigo'),
          ),
          BotaoPadrao(
              label: 'Confirmar',
              onPressed: () async {
                OverlayApp.iniciaOverlay(myNavigatorKey.currentState!.context);
                final geolocalizacao = await _pegarGeolocalizacao();
                var model = AssinaturaEletronicaModel(
                    idAssinaturaDigital: documento.idAssinaturaDigital,
                    codigoEmail: codigoEmail.text,
                    deslocamentoFusoHorarioUsuario:
                        DateTime.now().timeZoneOffset.inMinutes.toString(),
                    evidencias: Evidencias(geolocalizacao: geolocalizacao!));
                final result = await AssinaturaEletronicaImpl(
                        assinaturaEletronicaModel: model)
                    .finalizarAssinatura();
                if (result.error != null) {
                  OverlayApp.terminaOverlay();
                  Fluttertoast.showToast(
                      msg:
                          'Houve um erro ao assinar o documento, tente novamente.');
                  isErroAssinatura = true;
                } else {
                  OverlayApp.terminaOverlay();
                }
              }),
          BotaoPadrao(label: 'Cancelar', onPressed: () {})
        ],
      ),
    );
  }

  Widget confirmarAssinaturaDialog(InformacaoAssinante assinante) {
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    return AlertDialog(
      icon: Icon(LineIcons.exclamationCircle, color: Colors.yellow.shade700),
      title: Column(
        children: [
          Text(
            'Você confirma a assinatura de todos os documentos da operação ${assinaturaProvider.assinaturaSelecionada!.siglaProduto} nº${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}',
            style: myNavigatorKey.currentContext!.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          BotaoPadrao(
              label: 'Confirmar',
              onPressed: () async {
                await _finalizarAssinaturaDigital(assinante.documentos);
                Modular.to.pop();
              }),
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

  Widget _operacaoAssinada() {
    return AlertDialog(
      icon: Icon(
        Icons.check_circle_outline,
        color: myNavigatorKey.currentState!.context.primaryColor,
      ),
      title: Column(
        children: [
          Text(
            "Assinatura Digital Confirmada Com Sucesso!",
            style: myNavigatorKey.currentContext!.textTheme.labelMedium,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        'Quando sua operação possuir o numero de assinaturas necessárias, ela passará para o status de ',
                    style: myNavigatorKey.currentContext!.textTheme.bodyMedium),
                TextSpan(
                    text: '\"Assinada\". ',
                    style:
                        myNavigatorKey.currentContext!.textTheme.labelMedium),
              ]),
            ),
          ),
          Text(
              'Você pode acompanhar o status da sua assinatura clicando no botão abaixo.',
              style: myNavigatorKey.currentContext!.textTheme.bodyMedium),
          BotaoPadrao(label: 'Acompanhar Assinaturas', onPressed: () {}),
          BotaoPadrao(
              label: 'Fazer nova assinatura', filled: false, onPressed: () {}),
        ],
      ),
    );
  }
}

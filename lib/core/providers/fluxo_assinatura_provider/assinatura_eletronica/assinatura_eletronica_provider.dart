// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_impl.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/iniciar_assinatura_eletronica_impl.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/main.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/finalizar_assinatura_eletronica/finalizar_assinatura_eletronica_model.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/iniciar_assinatura_eletronica/iniciar_assinatura_eletronica_model.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:Srm_Asset/widgets/popup_assinatura_feita.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:validatorless/validatorless.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura_eletronica/response/resposta_inic_ass_eletronica.dart';
import '../../../../widgets/loader_widget.dart';
import '../../../constants/route_labels.dart';
import '../../../utils/handle_permissions.dart';
import '../../monitor_operacao_provider/monitor_operacoes_provider.dart';

class AssinaturaEletronicaProvider extends ChangeNotifier {
  FinalizarAssinaturaEletronicaModel? _assinaturaEletronicaModel;

  FinalizarAssinaturaEletronicaModel? get assinaturaEletronica =>
      _assinaturaEletronicaModel;

  final _formKey = GlobalKey<FormState>();

  late int _codigoOperacao;

  int get codigoOperacao => _codigoOperacao;

  set codigoOperacao(int cod) {
    _codigoOperacao = cod;
    notifyListeners();
  }

  AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();

  set assinaturaEletronica(
      FinalizarAssinaturaEletronicaModel? assinaturaEletronicaModel) {
    _assinaturaEletronicaModel = assinaturaEletronicaModel;
    notifyListeners();
  }

  late ResponseInicAssinaturaEletronica _respostaAssinaturaEletronica;

  ResponseInicAssinaturaEletronica get respostaAssinaturaEletronica =>
      _respostaAssinaturaEletronica;

  set respostaAssinaturaEletronica(ResponseInicAssinaturaEletronica resposta) {
    _respostaAssinaturaEletronica = resposta;
    notifyListeners();
  }

  Future<Geolocalizacao?> _pegarGeolocalizacao() async {
    final permission = await Geolocator.requestPermission();
    if(permission == PermissionStatus.denied){
      log('permissao negada');
      return null;
    }
    try {
      final posicao = await Geolocator.getCurrentPosition();
      log("localizacao: ${posicao.longitude}");
      return Geolocalizacao(
          latitude: posicao.latitude.toString(),
          longitude: posicao.longitude.toString(),
          precisao: posicao.accuracy.toString());
    }catch (e, s){
      log("Erro ao pegar localizacao $e, $s");
    }
  }

  bool isErroAssinatura = false;
  int contador = 0;

  void montarRequisicao(String codEmail) async {
    final geolocalizacao = await _pegarGeolocalizacao();
    var model = FinalizarAssinaturaEletronicaModel(
        codigoEmail: codEmail,
        deslocamentoFusoHorarioUsuario:
            DateTime.now().timeZoneOffset.inMinutes.toString(),
        evidencias: Evidencias(geolocalizacao: geolocalizacao!),
        chaveDocumento: respostaAssinaturaEletronica.chaveDocumento,
        codigoOperacao: codigoOperacao,
        idDocumentoLacuna: respostaAssinaturaEletronica.idDocumentoLacuna,
        ticket: respostaAssinaturaEletronica.ticket);
  }

  Future<bool> _finalizarAssinatura(String codEmail) async {
    try{
        final geolocalizacao = await _pegarGeolocalizacao();
        var model = FinalizarAssinaturaEletronicaModel(
            codigoEmail: codEmail,
            deslocamentoFusoHorarioUsuario:
            DateTime.now().timeZoneOffset.inMinutes.toString(),
            evidencias: Evidencias(geolocalizacao: geolocalizacao!),
            chaveDocumento: respostaAssinaturaEletronica.chaveDocumento,
            codigoOperacao: codigoOperacao,
            idDocumentoLacuna: respostaAssinaturaEletronica.idDocumentoLacuna,
            ticket: respostaAssinaturaEletronica.ticket);
        final result =
        await AssinaturaEletronicaImpl(assinaturaEletronicaModel: model)
            .finalizarAssinatura();
        return result.error == null;
    }catch(e,s){
      log("$e,$s");
      return false;
    }
    return false;
  }

  _informarCodigoEmail(BuildContext context) {
    final _overlayLoader = OverlayEntry(
      builder: (context) => const Material(
        color: Colors.transparent,
        child: Loader(),
      ),
    );
    TextEditingController codigoEmail = TextEditingController();
    showDialog(
      context: myNavigatorKey.currentState!.context,
      builder: (context) => AlertDialog(
        icon: Icon(
          LineIcons.exclamationCircle,
          color: context.focusColor,
          size: 50,
        ),
        title: Column(
          children: [
            Text(
                'Por favor, informe o codigo recebido em seu email para assinar a operação ${assinaturaProvider.assinaturaSelecionada!.siglaProduto} nº${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: codigoEmail,
                        decoration: const InputDecoration(
                          labelText: 'Informe o Codigo',
                          hintText: 'Informe o codigo',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required(
                                'Por favor, informe o codigo do email.'),
                            Validatorless.number(
                                'O codigo deve ser composto por numeros.')
                          ],
                        ),
                      ),
                    ),
                    BotaoPadrao(
                        label: 'Confirmar',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Overlay.of(context).insert(_overlayLoader);
                            var sucess =
                                await _finalizarAssinatura(codigoEmail.text);
                            if (sucess) {
                              _overlayLoader.remove();
                              Modular.to.pop();
                              showDialog(
                                  context: context,
                                  builder: (context) => AssinaturaCompletaPopUp(
                                      codigoOperacao: codigoOperacao));
                            } else {
                              _overlayLoader.remove();
                              Fluttertoast.showToast(
                                  msg:
                                      'Houve um erro ao assinar o documento, tente novamente.');
                            }
                          }
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: BotaoPadrao(
                          label: 'Cancelar',
                          onPressed: () {
                            Modular.to.pop();
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmarAssinaturaDialog(
      InformacaoAssinante assinante, BuildContext context) {
    final _overlayLoader = OverlayEntry(
      builder: (context) => const Material(
        color: Colors.transparent,
        child: Loader(),
      ),
    );
    return AlertDialog(
      icon: Icon(
        LineIcons.exclamationCircle,
        color: context.focusColor,
        size: 50,
      ),
      title: Column(
        children: [
          Text(
            'Você confirma a assinatura de todos os documentos da operação ${assinaturaProvider.assinaturaSelecionada!.siglaProduto} nº${codigoOperacao}',
            style: myNavigatorKey.currentContext!.textTheme.bodyMedium,
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
                              codigoOperacao: codigoOperacao))
                      .iniciarAssinaturaEletronica();
                  if (response.error != null) {
                    _overlayLoader.remove();
                    Fluttertoast.showToast(
                        msg:
                            'Erro ao iniciar assinatura, tente novamente mais tarde.');
                  } else {
                    _overlayLoader.remove();
                    Modular.to.pop();
                    _informarCodigoEmail(context);
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

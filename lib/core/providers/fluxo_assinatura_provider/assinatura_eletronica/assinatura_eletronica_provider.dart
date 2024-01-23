// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/size_screen_extensions.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_impl.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/iniciar_assinatura_eletronica_impl.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/utils/handle_permissions.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/main.dart';
import 'package:modular_study/models/fluxo_assinatura_model/finalizar_assinatura_eletronica/finalizar_assinatura_eletronica_model.dart';
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura_eletronica/iniciar_assinatura_eletronica_model.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

import '../../../../models/fluxo_assinatura_model/iniciar_assinatura_eletronica/response/resposta_inic_ass_eletronica.dart';
import '../../../../widgets/loader_widget.dart';
import '../../monitor_operacao_provider/monitor_operacoes_provider.dart';

class AssinaturaEletronicaProvider extends ChangeNotifier {
  FinalizarAssinaturaEletronicaModel? _assinaturaEletronicaModel;

  FinalizarAssinaturaEletronicaModel? get assinaturaEletronica =>
      _assinaturaEletronicaModel;

  late int _codOperacao;

  int get codOperacao => _codOperacao;

  set codOperacao(int cod) {
    _codOperacao = cod;
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
    final posicao = await Geolocator.getCurrentPosition();

    return Geolocalizacao(
        latitude: posicao.latitude.toString(),
        longitude: posicao.longitude.toString(),
        precisao: posicao.accuracy.toString());
  }

  bool isErroAssinatura = false;
  int contador = 0;

  Future<bool> _finalizarAssinatura(String codEmail) async {
    bool permissaoConcedida = await HandlePermissions.permissaoLocalizacao();
    if (permissaoConcedida) {
      final geolocalizacao = await _pegarGeolocalizacao();
      var model = FinalizarAssinaturaEletronicaModel(
          codigoEmail: codEmail,
          deslocamentoFusoHorarioUsuario:
              DateTime.now().timeZoneOffset.inMinutes.toString(),
          evidencias: Evidencias(geolocalizacao: geolocalizacao!),
          chaveDocumento: respostaAssinaturaEletronica.chaveDocumento,
          codigoOperacao: codOperacao,
          idDocumentoLacuna: respostaAssinaturaEletronica.idDocumentoLacuna,
          ticket: respostaAssinaturaEletronica.ticket);
      final result =
          await AssinaturaEletronicaImpl(assinaturaEletronicaModel: model)
              .finalizarAssinatura();
      if (result.error != null) {
        return false;
      }
      return true;
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
          color: Colors.yellow.shade700,
          size: 50.r,
        ),
        title: Column(
          children: [
            Text(
                'Por favor, informe o codigo recebido em seu email para assinar a operação ${assinaturaProvider.assinaturaSelecionada!.siglaProduto} nº${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: TextField(
                controller: codigoEmail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6.r))),
                    labelText: 'Informe o codigo',
                    hintText: 'Informe o codigo'),
              ),
            ),
            BotaoPadrao(
                label: 'Confirmar',
                onPressed: () async {
                  Overlay.of(context).insert(_overlayLoader);
                  var sucess = await _finalizarAssinatura(codigoEmail.text);
                  if (sucess) {
                    _overlayLoader.remove();
                    Modular.to.pop();
                    operacaoAssinada();
                  } else {
                    _overlayLoader.remove();
                    Fluttertoast.showToast(
                        msg:
                            'Houve um erro ao assinar o documento, tente novamente.');
                  }
                }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: BotaoPadrao(label: 'Cancelar', onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }

  Widget confirmarAssinaturaDialog(
      InformacaoAssinante assinante, BuildContext context) {
    return AlertDialog(
      icon: Icon(
        LineIcons.exclamationCircle,
        color: Colors.yellow.shade700,
        size: 50.r,
      ),
      title: Column(
        children: [
          Text(
            'Você confirma a assinatura de todos os documentos da operação ${assinaturaProvider.assinaturaSelecionada!.siglaProduto} nº${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}',
            style: myNavigatorKey.currentContext!.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: BotaoPadrao(
                label: 'Confirmar',
                onPressed: () async {
                  final response = await IniciarAssinaturaEletronicaImpl(
                          codOperacaoModel: IniciarAssinaturaEletronicaModel(
                              codigoOperacao: codOperacao))
                      .iniciarAssinaturaEletronica();
                  if (response.error != null) {
                    Fluttertoast.showToast(
                        msg:
                            'Erro ao iniciar assinatura, tente novamente mais tarde.');
                  } else {
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

  operacaoAssinada() {
    showDialog(
        context: myNavigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              icon: Icon(
                Icons.check_circle_outline,
                color: myNavigatorKey.currentState!.context.primaryColor,
                size: 50.r,
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
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                              'Quando sua operação possuir o numero de assinaturas necessárias, ela passará para o status de ',
                          style: myNavigatorKey
                              .currentContext!.textTheme.bodyMedium,
                        ),
                        TextSpan(
                            text: '\"Assinada\". ',
                            style: myNavigatorKey
                                .currentContext!.textTheme.labelMedium),
                      ]),
                    ),
                  ),
                  Text(
                      'Você pode acompanhar o status da sua assinatura clicando no botão abaixo.',
                      style:
                          myNavigatorKey.currentContext!.textTheme.bodyMedium),
                  BotaoPadrao(
                      label: 'Acompanhar Assinaturas',
                      onPressed: () {
                        final MonitorOperacoesProvider operacaoProvider =
                            Modular.get<MonitorOperacoesProvider>();
                        final AssinaturaProvider assinaturaProvider =
                            Modular.get<AssinaturaProvider>();
                        List<MonitorAssinaturasModel> assinaturasPendentes =
                            assinaturaProvider.assinaturasPendentes;
                        operacaoProvider.aconragemAssinatura(
                            assinaturaProvider.todasAssinaturas, codOperacao);
                        Modular.to.pushNamed(AppRoutes.assinaturaDigitalRoute,
                            arguments: {
                              'assinaturas':
                                  assinaturaProvider.todasAssinaturas,
                              'assinaturasPendentes': assinaturasPendentes,
                              'tab': 1,
                              'destacar': true,
                            });
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: BotaoPadrao(
                        label: 'Realizar nova assinatura',
                        filled: false,
                        onPressed: () {
                          Modular.to.navigate(AppRoutes.assinaturaDigitalRoute);
                        }),
                  ),
                ],
              ),
            ));
  }
}

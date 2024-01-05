import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_impl.dart';
import 'package:modular_study/models/fluxo_assinatura_model/assinatura_eletronica/assinatura_eletronica_model.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../../../views/home/assinaturas/selecionar_certificado.dart';
import '../../../constants/route_labels.dart';

class AssinaturaEletronicaProvider extends ChangeNotifier {
  AssinaturaEletronicaModel? _assinaturaEletronicaModel;

  AssinaturaEletronicaModel? get assinaturaEletronica =>
      _assinaturaEletronicaModel;

  set assinaturaEletronica(
      AssinaturaEletronicaModel? assinaturaEletronicaModel) {
    _assinaturaEletronicaModel = assinaturaEletronicaModel;
    notifyListeners();
  }

  static Future<void> finalizarAssinaturaDigital(List<Documento> documentos) async {
    List<AssinaturaEletronicaModel> documentosParaAssinar = [];
    for(var doc in documentos){
      documentosParaAssinar.add(AssinaturaEletronicaModel(idAssinaturaDigital: doc.idAssinaturaDigital, codigoEmail: "codigoEmail", deslocamentoFusoHorarioUsuario: deslocamentoFusoHorarioUsuario, evidencias: evidencias));
    }
    await AssinaturaEletronicaImpl(
        assinaturaEletronicaModel: assinaturaEletronicaModel).finalizarAssinatura();
  }
}
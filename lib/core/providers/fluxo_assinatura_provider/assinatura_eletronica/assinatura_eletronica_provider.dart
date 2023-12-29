import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_impl.dart';
import 'package:modular_study/models/fluxo_assinatura_model/assinatura_eletronica/assinatura_eletronica_model.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../../../views/home/assinaturas/selecionar_certificado.dart';
import '../../../constants/route_labels.dart';

class AssinaturaEletronicaProvider extends ChangeNotifier {
  int _statusCode = 0;

  int get statusCodeAssinaturaEletronica => _statusCode;

  set statusCodeAssinaturaEletronica(int cod) {
    _statusCode = cod;
    notifyListeners();
  }

  AssinaturaEletronicaModel? _assinaturaEletronicaModel;

  AssinaturaEletronicaModel? get assinaturaEletronica => _assinaturaEletronicaModel;

  set assinaturaEletronica(AssinaturaEletronicaModel? assinaturaEletronicaModel) {
    _assinaturaEletronicaModel = assinaturaEletronicaModel;
    notifyListeners();
  }

  void iniciarAssinaturaDigital(){

  }

  Future<dynamic> finalizarAssinaturaDigital(
      AssinaturaEletronicaModel assinaturaEletronicaModel) async {
    return await AssinaturaEletronicaImpl(
        assinaturaEletronicaModel: assinaturaEletronicaModel);
  }

  void isAssinaturaDigital(
      BuildContext context, InformacaoAssinante infoAssinante) async {
    final ImportarCertificadoProvider certificadoProvider =
        Modular.get<ImportarCertificadoProvider>();
    if (infoAssinante.eCPFAssinador) {
      certificadoProvider.listaCertificados =
          await certificadoProvider.listaCertificadosFuture();
      if (certificadoProvider.listaCertificados.isEmpty) {
        Modular.to.pushNamed(AppRoutes.importarCertificadoRoute);
      } else {
        showDialog(
          context: context,
          builder: (context) => SelecionarCertificado(),
          useSafeArea: true,
        );
      }
    } else {
      if(assinaturaEletronica != null){
        iniciarAssinaturaDigital();
      }
    }
  }
}

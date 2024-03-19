import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

class AssinaturaController {
  static iniciarFluxoAssinatura(List<Assinante> assinantes) {
    AuthProvider authProvider = Modular.get<AuthProvider>();
    String identificadorUsuario = authProvider.dataUser!.identificadorUsuario;

    bool assinaComCertificado = false;
    List<Documento> documentos = [];
    for (var info in assinantes) {
      for (var infoAssinador in info.informacoesAssinante) {
        if (infoAssinador.identificadorAssinador == identificadorUsuario) {
          assinaComCertificado = infoAssinador.eCPFAssinador;
          documentos = infoAssinador.documentos;
          break;
        }
      }
    }

    if (assinaComCertificado) {
    } else {

    }
  }
}

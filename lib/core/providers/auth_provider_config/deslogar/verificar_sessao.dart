import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:Srm_Asset/main.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';

class VerificarSessao {
  static limparDadosSessao() {
    AuthProvider authProvider = Modular.get<AuthProvider>();
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    ImportarCertificadoProvider certificadoProvider =
        Modular.get<ImportarCertificadoProvider>();
    IniciarAssinaturaProvider iniciarAssinaturaProvider =
        Modular.get<IniciarAssinaturaProvider>();
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    authProvider.limparDadosUsuario();
    themeProvider.limparDadosTema();
    certificadoProvider.limparDadosCertificados();
    iniciarAssinaturaProvider.limparHashs();
    assinaturaProvider.limparAssinaturas();
  }

  static sessaoExpirada() {
    limparDadosSessao();
    showDialog(
      context: myNavigatorKey.currentState!.context,
      builder: (context) => AlertDialogGenerico(
        title: 'Sessão Expirada',
        msg: 'Sua sessão expirou, faça o login novamente',
        onPressed: () {
          Modular.to.pop();
          Modular.to.navigate(Modular.initialRoute);
        },
      ),
    );
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';
import 'package:modular_study/core/providers/theme_provider.dart';

class VerificarSessao {
  static limparDadosSessao() {
    AuthProvider authProvider = Modular.get<AuthProvider>();
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    ImportarCertificadoProvider certificadoProvider = Modular.get<ImportarCertificadoProvider>();
    IniciarAssinaturaProvider iniciarAssinaturaProvider = Modular.get<IniciarAssinaturaProvider>();
    AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
    authProvider.limparDadosUsuario();
    themeProvider.limparDadosTema();
    certificadoProvider.limparDadosCertificados();
    iniciarAssinaturaProvider.limparHashs();
    assinaturaProvider.limparAssinaturas();
  }

  static sessaoExpirada(){
    SessionProvider sessionProvider = Modular.get<SessionProvider>();
    limparDadosSessao();
    sessionProvider.mostrarAlerta('Sua sessão expirou. Realize o login novamente!');
  }
}

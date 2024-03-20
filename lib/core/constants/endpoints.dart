import 'package:Srm_Asset/core/constants/enuns/ambiente.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EndPoints {
  EndPoints._();

  static final ThemeProvider _themeProvider = Modular.get<ThemeProvider>();

  //EndPoints
  static const baseURLProd = ' https://zuul.srmasset.com/direct/core-app-bff';
  static const baseURLHomol =
      'https://proxy-web-routers-homologacao.srmasset.com/direct/core-app-bff-homologacao/core-app-bff/v1';

  static final String baseURL =
      _themeProvider.ambienteSelecionado == Ambiente.Homologacao
          ? baseURLHomol
          : baseURLProd;

  static final String login = '$baseURL/autenticacoes';
  static final String assinatura = '$baseURL/assinaturas';
  static final iniciarAssinatura = "$assinatura/iniciar-assinatura";
  static final finalizarAssinatura = "$assinatura/finalizar-assinatura";
  static final finalizarAssinaturaEletronica =
      "$assinatura/finalizar-assinatura-eletronica";
  static final recuperarSenha = "$login/recuperar-senha";
  static final operacoes = "$baseURL/operacoes";
  static final iniciarAssinaturaEletronica =
      "$assinatura/iniciar-assinatura-eletronica";

  static montarUrlBaixarDocumento(int idAssinaturaDigital, bool visualizar) {
    return Uri.parse(
        "${EndPoints.assinatura}/$idAssinaturaDigital/arquivo?visualizar=$visualizar");
  }

  static final baixarCertificadoQrCode = "$baseURL/arquivos";

  //Urls Uteis
  static final siteQrCode = _themeProvider.ambienteSelecionado ==
          Ambiente.Homologacao
      ? "https://srm-web-homebanking-homologacao.interno.srmasset.com/envio-certificado"
      : 'https://homebanking.srmasset.com/envio-certificado';
  static final politicaPrivacidade = _themeProvider.isTemaSRM
      ? "https://srmasset.com/app/SRM_Politica-de-Privacidade-e-Tratamento-de-Dados-Pessoais.html"
      : "https://trusthub.com.br/new/assets/documents/Trust-Politica-de-Privacidade-e-Tratamento-de-Dados-Pessoais.html";

  static final termosDeUso = _themeProvider.isTemaSRM
      ? "https://www.srmasset.com/app/SRM_-_Termos_e_Condicoes_de_Uso.html"
      : "https://trusthub.com.br/new/assets/documents/Trust_-_Termos_e_Condicoes_de_Uso_para_abertura_da_Conta_Digital.html";
}

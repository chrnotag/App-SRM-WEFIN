import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

class EndPoints {
  EndPoints._();

  static const baseURL =
      'https://proxy-web-routers-homologacao.srmasset.com/direct/core-app-bff-homologacao/core-app-bff/v1';
  static const String login = '$baseURL/autenticacoes';
  static const String assinatura = '$baseURL/assinaturas';
  static const iniciarAssinatura = "$assinatura/iniciar-assinatura";
  static const finalizarAssinatura = "$assinatura/finalizar-assinatura";
  static const finalizarAssinaturaEletronica =
      "$assinatura/finalizar-assinatura-eletronica";
  static const recuperarSenha = "$login/recuperar-senha";
  static const operacoes = "$baseURL/operacoes";
  static const iniciarAssinaturaEletronica =
      "$assinatura/iniciar-assinatura-eletronica";

  static montarUrlBaixarDocumento(int idAssinaturaDigital, bool visualizar) {
    return Uri.parse("${EndPoints.assinatura}/$idAssinaturaDigital/arquivo?visualizar=$visualizar");
  }

  static const baixarCertificadoQrCode = "$baseURL/arquivos";
}

import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';

class EndPointsSRM extends Endpoint{

  @override
  // TODO: implement assinatura
  String get assinaturas => '$baseURL/assinaturas';

  @override
  // TODO: implement baixarCertificadoQrCode
  String get baixarCertificadoQrCode => "$baseURL/arquivos";

  @override
  // TODO: implement baseURL
  String get baseURL => 'https://zuul.srmasset.com/direct/core-app-bff';

  @override
  // TODO: implement finalizarAssinatura
  String get finalizarAssinatura => "$assinaturas/finalizar-assinatura";

  @override
  // TODO: implement finalizarAssinaturaEletronica
  String get finalizarAssinaturaEletronica => "$assinaturas/finalizar-assinatura-eletronica";

  @override
  // TODO: implement iniciarAssinatura
  String get iniciarAssinatura => "$assinaturas/iniciar-assinatura";

  @override
  // TODO: implement iniciarAssinaturaEletronica
  String get iniciarAssinaturaEletronica => "$assinaturas/iniciar-assinatura-eletronica";

  @override
  // TODO: implement login
  String get login => '$baseURL/autenticacoes';

  @override
  Uri montarUrlBaixarDocumento(int idAssinaturaDigital, bool visualizar) {
  return Uri.parse(
  "$assinaturas/$idAssinaturaDigital/arquivo?visualizar=$visualizar");
  }

  @override
  // TODO: implement operacoes
  String get operacoes => "$baseURL/operacoes";

  @override
  // TODO: implement politicaPrivacidade
  String get politicaPrivacidade => "https://srmasset.com/app/SRM_Politica-de-Privacidade-e-Tratamento-de-Dados-Pessoais.html";

  @override
  // TODO: implement recuperarSenha
  String get recuperarSenha => "$login/recuperar-senha";

  @override
  // TODO: implement siteQrCode
  String get siteQrCode => "https://homebanking.srmasset.com/envio-certificado";

  @override
  // TODO: implement termosDeUso
  String get termosDeUso => "https://www.srmasset.com/app/SRM_-_Termos_e_Condicoes_de_Uso.html";

  }
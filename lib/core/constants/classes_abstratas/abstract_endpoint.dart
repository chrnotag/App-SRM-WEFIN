abstract class Endpoint{
  String get baseURL;
  String get login;
  String get assinaturas;
  String get iniciarAssinatura;
  String get finalizarAssinatura;
  String get finalizarAssinaturaEletronica;
  String get recuperarSenha;
  String get operacoes;
  String get iniciarAssinaturaEletronica;
  Uri montarUrlBaixarDocumento(int idAssinaturaDigital, bool visualizar);
  String get baixarCertificadoQrCode;
  String get siteQrCode;
  String get politicaPrivacidade;
  String get termosDeUso;
  String get contaDigital;
  String get saldoContaDigital;
}
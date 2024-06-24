import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_impl.dart';

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
  String get extratoContaDigital;
  String get downloadExtratoContaDigital;
  Uri montarUrlPegarExtrato(String numeroConta, String dataInicial, String dataFinal, TipoConsultaExtrato tipoConsulta);
  String get transacoes;
  Uri montarUrlDownloadComprovanteTED(String codigoTransacao);
  String get carteiraConsolidada;
  String get geralCarteira;
  String get carteiraAberto;
  String get prazoLiquidez;
  String get carteiraRecebiveis;
  String get downloadRecebiveis;
}
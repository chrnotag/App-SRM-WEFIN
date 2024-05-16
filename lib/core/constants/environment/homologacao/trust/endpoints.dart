import 'package:Srm_Asset/core/constants/classes_abstratas/abstract_endpoint.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../providers/conta_digital/extrato/extrato_impl.dart';
import '../../../classes_abstratas/envirioment.dart';

class EndPointsTRUST extends Endpoint{
  @override
  // TODO: implement assinatura
  String get assinaturas => '$baseURL/assinaturas';

  @override
  // TODO: implement baixarCertificadoQrCode
  String get baixarCertificadoQrCode => "$baseURL/arquivos";

  @override
  // TODO: implement baseURL
  String get baseURL => 'https://core-app-bff-homologacao.srmasset.com/core-app-bff/v1';

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
  String get politicaPrivacidade => "https://trusthub.com.br/new/assets/documents/Trust-Politica-de-Privacidade-e-Tratamento-de-Dados-Pessoais.html";

  @override
  // TODO: implement recuperarSenha
  String get recuperarSenha => "$login/recuperar-senha";

  @override
  // TODO: implement siteQrCode
  String get siteQrCode => "https://srm-web-homebanking-homologacao.interno.srmasset.com/envio-certificado";

  @override
  // TODO: implement termosDeUso
  String get termosDeUso => "https://trusthub.com.br/new/assets/documents/Trust_-_Termos_e_Condicoes_de_Uso_para_abertura_da_Conta_Digital.html";

  @override
  // TODO: implement contaDigital
  String get contaDigital => "$baseURL/conta-digital";

  @override
  // TODO: implement saldoContaDigital
  String get saldoContaDigital => "$contaDigital/saldo";

  @override
  String get extratoContaDigital => "$contaDigital/extrato";

  @override
  String get downloadExtratoContaDigital => "$extratoContaDigital/download";

  @override
  Uri montarUrlPegarExtrato(String numeroConta, String dataInicial, String dataFinal, TipoConsultaExtrato tipoConsulta) {
    final ambiente = Modular.get<Environment>();
    return Uri.parse("${TipoConsultaExtrato.retornarEndpoint(tipoConsulta, ambiente)}?numeroContaTitular=$numeroConta&dataInicialExtrato=$dataInicial&dataFinalExtrato=$dataFinal");
  }
}

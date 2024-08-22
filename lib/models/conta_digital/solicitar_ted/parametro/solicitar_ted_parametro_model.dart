import 'package:json_annotation/json_annotation.dart';

part 'solicitar_ted_parametro_model.g.dart';

@JsonSerializable()
class SolicitarTedParametroModel {
  final double valor;
  final String tokenConfirmacao;
  final Beneficiario beneficiario;
  final InformacoesAdicionais? informacoesAdicionais;
  final bool favoritar;
  final String data;

  SolicitarTedParametroModel({
    required this.valor,
    required this.tokenConfirmacao,
    required this.beneficiario,
    this.informacoesAdicionais,
    required this.favoritar,
    required this.data,
  });

  factory SolicitarTedParametroModel.fromJson(Map<String, dynamic> json) => _$SolicitarTedParametroModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitarTedParametroModelToJson(this);

}

@JsonSerializable()
class Beneficiario {
  final String codigoBanco;
  final String agencia;
  final String numeroConta;
  final String tipoConta;
  final String identificadorBeneficiario;
  final String nomeBeneficiario;
  final bool? favorito;
  final int? idBeneficiario;

  Beneficiario({
    required this.codigoBanco,
    required this.agencia,
    required this.numeroConta,
    required this.tipoConta,
    required this.identificadorBeneficiario,
    required this.nomeBeneficiario,
    this.favorito,
    this.idBeneficiario,
  });

  factory Beneficiario.fromJson(Map<String, dynamic> json) => _$BeneficiarioFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiarioToJson(this);

}

@JsonSerializable()
class InformacoesAdicionais {
  final String codigoFinalidade;
  final String descricao;

  InformacoesAdicionais({
    required this.codigoFinalidade,
    required this.descricao,
  });

  factory InformacoesAdicionais.fromJson(Map<String, dynamic> json) => _$InformacoesAdicionaisFromJson(json);

  Map<String, dynamic> toJson() => _$InformacoesAdicionaisToJson(this);

}

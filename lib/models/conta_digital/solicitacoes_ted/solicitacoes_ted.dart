import 'package:json_annotation/json_annotation.dart';

part 'solicitacoes_ted.g.dart';

@JsonSerializable()
class SolicitacaoTed {
  final List<Iten> itens;
  final double valorTotalItens;

  SolicitacaoTed({
    required this.itens,
    required this.valorTotalItens,
  });

  factory SolicitacaoTed.fromJson(Map<String, dynamic> json) => _$SolicitacaoTedFromJson(json);

  Map<String, dynamic> toJson() => _$SolicitacaoTedToJson(this);

}

@JsonSerializable()
class Iten {
  final double valor;
  final String descricao;
  final String identificador;
  final Status status;
  final Beneficiario beneficiario;
  final DateTime dataCriacao;

  Iten({
    required this.valor,
    required this.descricao,
    required this.identificador,
    required this.status,
    required this.beneficiario,
    required this.dataCriacao,
  });

  factory Iten.fromJson(Map<String, dynamic> json) => _$ItenFromJson(json);

  Map<String, dynamic> toJson() => _$ItenToJson(this);

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
class Status {
  final String codigo;
  final String nome;
  final String descricao;

  Status({
    required this.codigo,
    required this.nome,
    required this.descricao,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

}

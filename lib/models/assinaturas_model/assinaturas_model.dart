import 'package:json_annotation/json_annotation.dart';

part 'assinaturas_model.g.dart';

@JsonSerializable()
class AssinaturasModel {
  int codigoOperacao;
  String statusAssinaturaDigital;
  String siglaProduto;
  String statusOperacao;
  double valorBruto;
  double valorLiquido;
  String dataOperacao;
  List<Assinantes> assinantes;

  AssinaturasModel({
    required this.codigoOperacao,
    required this.statusAssinaturaDigital,
    required this.siglaProduto,
    required this.statusOperacao,
    required this.valorBruto,
    required this.valorLiquido,
    required this.dataOperacao,
    required this.assinantes,
  });

  factory AssinaturasModel.fromJson(Map<String, dynamic> json) =>
      _$AssinaturasModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssinaturasModelToJson(this);
}

@JsonSerializable()
class Assinantes {
  String nomeAssinante;
  String identificadorAssinante;
  List<InformacaoAssinante> informacoesAssinante;

  Assinantes({
    required this.nomeAssinante,
    required this.identificadorAssinante,
    required this.informacoesAssinante,
  });

  factory Assinantes.fromJson(Map<String, dynamic> json) =>
      _$AssinantesFromJson(json);

  Map<String, dynamic> toJson() => _$AssinantesToJson(this);
}

@JsonSerializable()
class InformacaoAssinante {
  List<String> papeis;
  List<Documentos> documentos;
  String identificadorAssinador;
  String tipoAssinatura;
  String? dataAssinatura;
  String statusAssinatura;
  String? emailAssinador;
  String? idRegistroLacuna;
  bool? eCPFAssinador;
  String? idAssinaturaDigital;
  String? nomeProcurador;

  InformacaoAssinante({
    required this.papeis,
    required this.documentos,
    required this.identificadorAssinador,
    required this.tipoAssinatura,
    required this.dataAssinatura,
    required this.statusAssinatura,
    this.emailAssinador,
    this.idRegistroLacuna,
    this.eCPFAssinador,
    this.idAssinaturaDigital,
    this.nomeProcurador,
  });

  factory InformacaoAssinante.fromJson(Map<String, dynamic> json) =>
      _$InformacaoAssinanteFromJson(json);

  Map<String, dynamic> toJson() => _$InformacaoAssinanteToJson(this);
}

@JsonSerializable()
class Documentos {
  int idAssinaturaDigital;
  String nome;

  Documentos({
    required this.idAssinaturaDigital,
    required this.nome,
  });

  factory Documentos.fromJson(Map<String, dynamic> json) =>
      _$DocumentosFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentosToJson(this);
}

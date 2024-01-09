import 'package:json_annotation/json_annotation.dart';

part 'monitor_assinaturas_model.g.dart';

@JsonSerializable()
class MonitorAssinaturasModel {
  int codigoOperacao;
  String statusAssinaturaDigital;
  String siglaProduto;
  String statusOperacao;
  double valorBruto;
  double valorLiquido;
  String dataOperacao;
  List<Assinante> assinantes;

  MonitorAssinaturasModel({
    required this.codigoOperacao,
    required this.statusAssinaturaDigital,
    required this.siglaProduto,
    required this.statusOperacao,
    required this.valorBruto,
    required this.valorLiquido,
    required this.dataOperacao,
    required this.assinantes,
  });

  factory MonitorAssinaturasModel.fromJson(Map<String, dynamic> json) =>
      _$MonitorAssinaturasModelFromJson(json);

  Map<String, dynamic> toJson() => _$MonitorAssinaturasModelToJson(this);
}

@JsonSerializable()
class Assinante {
  String nomeAssinante;
  String identificadorAssinante;
  List<InformacaoAssinante> informacoesAssinante;

  Assinante({
    required this.nomeAssinante,
    required this.identificadorAssinante,
    required this.informacoesAssinante,
  });

  factory Assinante.fromJson(Map<String, dynamic> json) =>
      _$AssinanteFromJson(json);

  Map<String, dynamic> toJson() => _$AssinanteToJson(this);
}

@JsonSerializable()
class InformacaoAssinante {
  List<String> papeis;
  List<Documento> documentos;
  String identificadorAssinador;
  String? nomeProcurador;
  String tipoAssinatura;
  String? dataAssinatura;
  String statusAssinatura;
  bool eCPFAssinador;

  InformacaoAssinante({
    required this.papeis,
    required this.documentos,
    required this.identificadorAssinador,
    required this.tipoAssinatura,
    required this.dataAssinatura,
    required this.statusAssinatura,
    required this.eCPFAssinador,
    this.nomeProcurador,
  });

  factory InformacaoAssinante.fromJson(Map<String, dynamic> json) =>
      _$InformacaoAssinanteFromJson(json);

  Map<String, dynamic> toJson() => _$InformacaoAssinanteToJson(this);
}

@JsonSerializable()
class Documento {
  int idAssinaturaDigital;
  String nome;

  Documento({
    required this.idAssinaturaDigital,
    required this.nome,
  });

  factory Documento.fromJson(Map<String, dynamic> json) =>
      _$DocumentoFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentoToJson(this);
}

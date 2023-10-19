import 'package:json_annotation/json_annotation.dart';

part 'assinaturas_model.g.dart';

@JsonSerializable()
class AssinaturasModel {
  int codigoOperacao;
  String statusAssinaturaDigital;
  String siglaProduto;
  String statusOperacao;
  int valorBruto;
  double valorLiquido;
  DateTime dataOperacao;
  String urlAssinador;
  List<Assinante> assinantes;

  AssinaturasModel({
    required this.codigoOperacao,
    required this.statusAssinaturaDigital,
    required this.siglaProduto,
    required this.statusOperacao,
    required this.valorBruto,
    required this.valorLiquido,
    required this.dataOperacao,
    required this.urlAssinador,
    required this.assinantes,
  });

  factory AssinaturasModel.fromJson(Map<String, dynamic> json) =>
      _$AssinaturasModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssinaturasModelToJson(this);
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
  List<String> documentos;
  String identificadorAssinador;
  String nomeProcurador;
  String tipoAssinatura;
  String dataAssinatura;
  String statusAssinatura;

  InformacaoAssinante({
    required this.papeis,
    required this.documentos,
    required this.identificadorAssinador,
    required this.nomeProcurador,
    required this.tipoAssinatura,
    required this.dataAssinatura,
    required this.statusAssinatura,
  });
  factory InformacaoAssinante.fromJson(Map<String, dynamic> json) =>
      _$InformacaoAssinanteFromJson(json);

  Map<String, dynamic> toJson() => _$InformacaoAssinanteToJson(this);
}

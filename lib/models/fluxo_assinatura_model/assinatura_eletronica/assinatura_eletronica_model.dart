import 'package:json_annotation/json_annotation.dart';

part 'assinatura_eletronica_model.g.dart';

@JsonSerializable()
class AssinaturaEletronicaModel {
  int idAssinaturaDigital;
  String codigoEmail;
  String deslocamentoFusoHorarioUsuario;
  Evidencias evidencias;

  AssinaturaEletronicaModel(
      {required this.idAssinaturaDigital,
      required this.codigoEmail,
      required this.deslocamentoFusoHorarioUsuario,
      required this.evidencias});

  factory AssinaturaEletronicaModel.fromJson(Map<String, dynamic> json) =>
      _$AssinaturaEletronicaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssinaturaEletronicaModelToJson(this);
}

@JsonSerializable()
class Evidencias {
  Geolocalizacao geolocalizacao;

  Evidencias({required this.geolocalizacao});

  factory Evidencias.fromJson(Map<String, dynamic> json) =>
      _$EvidenciasFromJson(json);

  Map<String, dynamic> toJson() => _$EvidenciasToJson(this);
}

@JsonSerializable()
class Geolocalizacao {
  String latitude;
  String longitude;
  String precisao;

  Geolocalizacao(
      {required this.latitude,
      required this.longitude,
      required this.precisao});

  factory Geolocalizacao.fromJson(Map<String, dynamic> json) =>
      _$GeolocalizacaoFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocalizacaoToJson(this);
}

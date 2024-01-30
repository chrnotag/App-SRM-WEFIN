import 'package:json_annotation/json_annotation.dart';

part 'finalizar_assinatura_eletronica_model.g.dart';

@JsonSerializable()
class FinalizarAssinaturaEletronicaModel {
  int codigoOperacao;
  String deslocamentoFusoHorarioUsuario;
  Evidencias evidencias;
  String codigoEmail;
  String ticket;
  String chaveDocumento;
  String idDocumentoLacuna;

  FinalizarAssinaturaEletronicaModel(
      {required this.codigoOperacao,
      required this.deslocamentoFusoHorarioUsuario,
      required this.evidencias,
      required this.codigoEmail,
      required this.ticket,
      required this.chaveDocumento,
      required this.idDocumentoLacuna});

  factory FinalizarAssinaturaEletronicaModel.fromJson(
          Map<String, dynamic> json) =>
      _$FinalizarAssinaturaEletronicaModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FinalizarAssinaturaEletronicaModelToJson(this);
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

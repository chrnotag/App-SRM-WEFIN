import 'package:json_annotation/json_annotation.dart';

part 'resposta_inic_ass_eletronica.g.dart';

@JsonSerializable()
class ResponseInicAssinaturaEletronica {
  String ticket;
  String chaveDocumento;
  String idDocumentoLacuna;

  ResponseInicAssinaturaEletronica(
      {required this.ticket,
      required this.chaveDocumento,
      required this.idDocumentoLacuna});

  factory ResponseInicAssinaturaEletronica.fromJson(
          Map<String, dynamic> json) =>
      _$ResponseInicAssinaturaEletronicaFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ResponseInicAssinaturaEletronicaToJson(this);
}

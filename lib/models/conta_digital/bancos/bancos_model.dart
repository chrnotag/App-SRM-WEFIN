import 'package:json_annotation/json_annotation.dart';

part 'bancos_model.g.dart';

@JsonSerializable()
class BancosModel {
  final int? identificador;
  final String codigo;
  final String nome;
  final String ispb;

  BancosModel({
    required this.identificador,
    required this.codigo,
    required this.nome,
    required this.ispb,
  });

  factory BancosModel.fromJson(Map<String, dynamic> json) => _$BancosModelFromJson(json);

  Map<String, dynamic> toJson() => _$BancosModelToJson(this);
}

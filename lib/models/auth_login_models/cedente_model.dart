import 'package:json_annotation/json_annotation.dart';

part 'cedente_model.g.dart';

@JsonSerializable()
class CedenteModel {
  CedenteModel({
    required this.identificador,
    required this.nome,
  });

  late final String identificador;
  late final String nome;

  factory CedenteModel.fromJson(Map<String, dynamic> json) =>
      _$CedenteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CedenteModelToJson(this);
}

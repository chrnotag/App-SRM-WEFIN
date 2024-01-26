import 'package:json_annotation/json_annotation.dart';

part 'cedente_model.g.dart';

@JsonSerializable()
class CedenteModel {
  CedenteModel({
    required this.identificador,
    required this.nome,
    required this.assinaturaPendente
  });

  late final String identificador;
  late final String nome;
  late final int assinaturaPendente;

  factory CedenteModel.fromJson(Map<String, dynamic> json) =>
      _$CedenteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CedenteModelToJson(this);
}

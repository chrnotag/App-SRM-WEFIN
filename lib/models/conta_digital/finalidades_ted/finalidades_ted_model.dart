import 'package:json_annotation/json_annotation.dart';

part 'finalidades_ted_model.g.dart';

@JsonSerializable()
class FinalidadesTedModel {
  final String codigo;
  final String descricao;

  FinalidadesTedModel({
    required this.codigo,
    required this.descricao,
  });

  factory FinalidadesTedModel.fromJson(Map<String, dynamic> json) => _$FinalidadesTedModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinalidadesTedModelToJson(this);
}


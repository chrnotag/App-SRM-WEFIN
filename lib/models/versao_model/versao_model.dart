import 'package:json_annotation/json_annotation.dart';

part 'versao_model.g.dart';


@JsonSerializable()
class VersaoModel{
  final String versao;
  final String sistemaOperacional;
  final String plataforma;
  const VersaoModel({required this.versao, required this.sistemaOperacional, required this.plataforma});

  factory VersaoModel.fromJson(Map<String, dynamic> json) => _$VersaoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersaoModelToJson(this);
}
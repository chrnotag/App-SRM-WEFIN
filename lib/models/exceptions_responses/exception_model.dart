import 'package:json_annotation/json_annotation.dart';

part 'exception_model.g.dart';

@JsonSerializable()
class ExceptionModel {
  final String? codigo;
  final String? mensagem;
  final DateTime? dataHora;
  final String? httpStatus;
  final List<String>? erros;

  ExceptionModel({
    this.codigo,
    this.mensagem,
    this.dataHora,
    this.httpStatus,
    this.erros,
  });

  factory ExceptionModel.fromJson(Map<String, dynamic> json) =>
      _$ExceptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExceptionModelToJson(this);
}

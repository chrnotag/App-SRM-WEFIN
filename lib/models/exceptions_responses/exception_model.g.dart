// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceptionModel _$ExceptionModelFromJson(Map<String, dynamic> json) =>
    ExceptionModel(
      codigo: json['codigo'] as String?,
      mensagem: json['mensagem'] as String?,
      dataHora: json['dataHora'] == null
          ? null
          : DateTime.parse(json['dataHora'] as String),
      httpStatus: json['httpStatus'] as String?,
      erros:
          (json['erros'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ExceptionModelToJson(ExceptionModel instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'mensagem': instance.mensagem,
      'dataHora': instance.dataHora?.toIso8601String(),
      'httpStatus': instance.httpStatus,
      'erros': instance.erros,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_operacao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperacaoModel _$OperacaoModelFromJson(Map<String, dynamic> json) =>
    OperacaoModel(
      papeis:
          (json['papeis'] as List<dynamic>?)?.map((e) => e as String).toList(),
      procurador: json['procurador'] as String?,
      situacao: json['situacao'] as String?,
      assinantes: (json['assinantes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      documentos: (json['documentos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tipoAssinatura: json['tipoAssinatura'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$OperacaoModelToJson(OperacaoModel instance) =>
    <String, dynamic>{
      'papeis': instance.papeis,
      'procurador': instance.procurador,
      'situacao': instance.situacao,
      'assinantes': instance.assinantes,
      'documentos': instance.documentos,
      'tipoAssinatura': instance.tipoAssinatura,
      'data': instance.data,
    };

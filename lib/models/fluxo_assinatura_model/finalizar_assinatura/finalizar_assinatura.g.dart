// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalizar_assinatura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalizarAssinaturaModel _$FinalizarAssinaturaModelFromJson(
        Map<String, dynamic> json) =>
    FinalizarAssinaturaModel(
      codigoOperacao: json['codigoOperacao'] as int,
      hashAssinado: json['hashAssinado'] as String,
      chaveDocumento: json['chaveDocumento'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$FinalizarAssinaturaModelToJson(
        FinalizarAssinaturaModel instance) =>
    <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'hashAssinado': instance.hashAssinado,
      'chaveDocumento': instance.chaveDocumento,
      'token': instance.token,
    };

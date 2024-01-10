// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iniciar_assinatura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IniciarAssinaturaModel _$IniciarAssinaturaModelFromJson(
        Map<String, dynamic> json) =>
    IniciarAssinaturaModel(
      certificadoBase64: json['certificadoBase64'] as String,
      codigoOperacao: json['codigoOperacao'] as int,
    );

Map<String, dynamic> _$IniciarAssinaturaModelToJson(
        IniciarAssinaturaModel instance) =>
    <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'certificadoBase64': instance.certificadoBase64,
    };

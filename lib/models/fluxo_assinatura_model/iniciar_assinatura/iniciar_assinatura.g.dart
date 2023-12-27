// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iniciar_assinatura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IniciarAssinaturaModel _$IniciarAssinaturaModelFromJson(
        Map<String, dynamic> json) =>
    IniciarAssinaturaModel(
      certificado: json['certificado'] as String,
      codigoOperacao: json['codigoOperacao'] as int,
    );

Map<String, dynamic> _$IniciarAssinaturaModelToJson(
        IniciarAssinaturaModel instance) =>
    <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'certificado': instance.certificado,
    };

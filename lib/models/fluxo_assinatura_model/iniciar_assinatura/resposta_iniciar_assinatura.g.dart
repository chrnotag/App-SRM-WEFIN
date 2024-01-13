// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta_iniciar_assinatura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespostaIniciarAssinaturaModel _$RespostaIniciarAssinaturaModelFromJson(
        Map<String, dynamic> json) =>
    RespostaIniciarAssinaturaModel(
      hashParaAssinar: json['hashParaAssinar'] as String,
      token: json['token'] as String,
      chaveDocumento: json['chaveDocumento'] as String,
    );

Map<String, dynamic> _$RespostaIniciarAssinaturaModelToJson(
        RespostaIniciarAssinaturaModel instance) =>
    <String, dynamic>{
      'hashParaAssinar': instance.hashParaAssinar,
      'token': instance.token,
      'chaveDocumento': instance.chaveDocumento,
    };

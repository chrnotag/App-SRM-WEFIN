// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta_iniciar_assinatura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespostaIniciarAssinaturaModel _$RespostaIniciarAssinaturaModelFromJson(
        Map<String, dynamic> json) =>
    RespostaIniciarAssinaturaModel(
      hashParaAssinar: RespostaIniciarAssinaturaModel._dataFromBase64(
          json['hashParaAssinar'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$RespostaIniciarAssinaturaModelToJson(
        RespostaIniciarAssinaturaModel instance) =>
    <String, dynamic>{
      'hashParaAssinar': RespostaIniciarAssinaturaModel._dataToBase64(
          instance.hashParaAssinar),
      'token': instance.token,
    };

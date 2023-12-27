// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta_iniciar_assinatura.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespostaIniciarAssinatura _$RespostaIniciarAssinaturaFromJson(
        Map<String, dynamic> json) =>
    RespostaIniciarAssinatura(
      hashParaAssinar: json['hashParaAssinar'] as Uint8List,
      token: json['token'] as String,
    );

Map<String, dynamic> _$RespostaIniciarAssinaturaToJson(
        RespostaIniciarAssinatura instance) =>
    <String, dynamic>{
      'hashParaAssinar': instance.hashParaAssinar,
      'token': instance.token,
    };

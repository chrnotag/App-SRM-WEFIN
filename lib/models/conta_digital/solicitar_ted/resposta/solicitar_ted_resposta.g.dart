// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitar_ted_resposta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitarTedResposta _$SolicitarTedRespostaFromJson(
        Map<String, dynamic> json) =>
    SolicitarTedResposta(
      data: DateTime.parse(json['data'] as String),
      evento: json['evento'] as String,
      status: json['status'] as String,
      transacao: json['transacao'] as String,
    );

Map<String, dynamic> _$SolicitarTedRespostaToJson(
        SolicitarTedResposta instance) =>
    <String, dynamic>{
      'data': instance.data.toIso8601String(),
      'evento': instance.evento,
      'status': instance.status,
      'transacao': instance.transacao,
    };

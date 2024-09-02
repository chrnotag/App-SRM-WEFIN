// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificacoes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificacoesModel _$NotificacoesModelFromJson(Map<String, dynamic> json) =>
    NotificacoesModel(
      titulo: json['titulo'] as String,
      mensagem: json['mensagem'] as String,
      lido: json['lido'] as bool,
      dataNotificacao: DateTime.parse(json['dataNotificacao'] as String),
      idNotificacao: (json['idNotificacao'] as num).toInt(),
      nomeCanal: json['nomeCanal'] as String,
    );

Map<String, dynamic> _$NotificacoesModelToJson(NotificacoesModel instance) =>
    <String, dynamic>{
      'titulo': instance.titulo,
      'mensagem': instance.mensagem,
      'lido': instance.lido,
      'dataNotificacao': instance.dataNotificacao.toIso8601String(),
      'idNotificacao': instance.idNotificacao,
      'nomeCanal': instance.nomeCanal,
    };

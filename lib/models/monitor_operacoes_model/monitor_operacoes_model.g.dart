// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor_operacoes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonitorOperacoesModel _$MonitorOperacoesModelFromJson(
        Map<String, dynamic> json) =>
    MonitorOperacoesModel(
      codigoOperacao: json['codigoOperacao'] as int,
      statusOperacao: json['statusOperacao'] as String,
      dataOperacao: json['dataOperacao'] as String,
      siglaProduto: json['siglaProduto'] as String,
      valorBruto: (json['valorBruto'] as num).toDouble(),
      valorLiquido: (json['valorLiquido'] as num).toDouble(),
    );

Map<String, dynamic> _$MonitorOperacoesModelToJson(
        MonitorOperacoesModel instance) =>
    <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'statusOperacao': instance.statusOperacao,
      'dataOperacao': instance.dataOperacao,
      'siglaProduto': instance.siglaProduto,
      'valorBruto': instance.valorBruto,
      'valorLiquido': instance.valorLiquido,
    };

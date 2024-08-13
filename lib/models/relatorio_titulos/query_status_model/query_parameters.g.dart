// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatorioQueryParams _$RelatorioQueryParamsFromJson(
        Map<String, dynamic> json) =>
    RelatorioQueryParams(
      dataInicialLiquidacao: json['dataInicialLiquidacao'] as String?,
      dataFinalLiquidacao: json['dataFinalLiquidacao'] as String?,
      dataInicialAVencer: json['dataInicialAVencer'] as String?,
      dataFinalAVencer: json['dataFinalAVencer'] as String?,
      statusRecebiveis: (json['statusRecebiveis'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$RelatorioEnumEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$RelatorioQueryParamsToJson(
        RelatorioQueryParams instance) =>
    <String, dynamic>{
      'dataInicialLiquidacao': instance.dataInicialLiquidacao,
      'dataFinalLiquidacao': instance.dataFinalLiquidacao,
      'dataInicialAVencer': instance.dataInicialAVencer,
      'dataFinalAVencer': instance.dataFinalAVencer,
      'statusRecebiveis': instance.statusRecebiveis
          ?.map((e) => _$RelatorioEnumEnumMap[e]!)
          .toList(),
    };

const _$RelatorioEnumEnumMap = {
  RelatorioEnum.A_VENCER: 'A VENCER',
  RelatorioEnum.VENCIDO: 'VENCIDO',
  RelatorioEnum.LIQUIDADO: 'LIQUIDADO',
};

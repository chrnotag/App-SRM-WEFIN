// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relatorio_titulos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListaTitulos _$ListaTitulosFromJson(Map<String, dynamic> json) => ListaTitulos(
      listaTitulos: (json['listaTitulos'] as List<dynamic>)
          .map((e) => Titulo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListaTitulosToJson(ListaTitulos instance) =>
    <String, dynamic>{
      'listaTitulos': instance.listaTitulos,
    };

Titulo _$TituloFromJson(Map<String, dynamic> json) => Titulo(
      codigoOperacao: json['codigoOperacao'] as String,
      dataLiquidacao: json['dataLiquidacao'] == null
          ? null
          : DateTime.parse(json['dataLiquidacao'] as String),
      dataVencimento: DateTime.parse(json['dataVencimento'] as String),
      documento: json['documento'] as String,
      id: (json['id'] as num).toInt(),
      identificadorCedente: json['identificadorCedente'] as String,
      identificadorSacado: json['identificadorSacado'] as String,
      kgfinPos: json['kgfinPos'] as bool,
      nomeSacado: json['nomeSacado'] as String,
      notaFiscal: json['notaFiscal'] as String?,
      produto: json['produto'] as String,
      status: $enumDecode(_$RelatorioEnumEnumMap, json['status']),
      valor: (json['valor'] as num).toDouble(),
    );

Map<String, dynamic> _$TituloToJson(Titulo instance) => <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'dataLiquidacao': instance.dataLiquidacao?.toIso8601String(),
      'dataVencimento': instance.dataVencimento.toIso8601String(),
      'documento': instance.documento,
      'id': instance.id,
      'identificadorCedente': instance.identificadorCedente,
      'identificadorSacado': instance.identificadorSacado,
      'kgfinPos': instance.kgfinPos,
      'nomeSacado': instance.nomeSacado,
      'notaFiscal': instance.notaFiscal,
      'produto': instance.produto,
      'status': _$RelatorioEnumEnumMap[instance.status]!,
      'valor': instance.valor,
    };

const _$RelatorioEnumEnumMap = {
  RelatorioEnum.A_VENCER: 'A VENCER',
  RelatorioEnum.VENCIDO: 'VENCIDO',
  RelatorioEnum.LIQUIDADO: 'LIQUIDADO',
};

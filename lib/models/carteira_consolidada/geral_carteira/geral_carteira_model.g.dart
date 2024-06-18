// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geral_carteira_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeralCarteiraModel _$GeralCarteiraModelFromJson(Map<String, dynamic> json) =>
    GeralCarteiraModel(
      valorTotalRecebiveisEmAberto: json['valorTotalRecebiveisEmAberto'] as double,
      valorTotalRecebiveisAVencer: json['valorTotalRecebiveisAVencer'] as double,
      valorTotalRecebiveisVencidos: json['valorTotalRecebiveisVencidos'] as double,
      valorTotalRecebiveisLiquidados:
          json['valorTotalRecebiveisLiquidados'] as double,
      quantidadeTotalRecebiveis: json['quantidadeTotalRecebiveis'] as int,
      quantidadeTotalRecebiveisAVencer:
          json['quantidadeTotalRecebiveisAVencer'] as int,
      quantidadeTotalRecebiveisVencidos:
          json['quantidadeTotalRecebiveisVencidos'] as int,
      quantidadeTotalRecebiveisLiquidados:
          json['quantidadeTotalRecebiveisLiquidados'] as int,
    );

Map<String, dynamic> _$GeralCarteiraModelToJson(GeralCarteiraModel instance) =>
    <String, dynamic>{
      'valorTotalRecebiveisEmAberto': instance.valorTotalRecebiveisEmAberto,
      'valorTotalRecebiveisAVencer': instance.valorTotalRecebiveisAVencer,
      'valorTotalRecebiveisVencidos': instance.valorTotalRecebiveisVencidos,
      'valorTotalRecebiveisLiquidados': instance.valorTotalRecebiveisLiquidados,
      'quantidadeTotalRecebiveis': instance.quantidadeTotalRecebiveis,
      'quantidadeTotalRecebiveisAVencer':
          instance.quantidadeTotalRecebiveisAVencer,
      'quantidadeTotalRecebiveisVencidos':
          instance.quantidadeTotalRecebiveisVencidos,
      'quantidadeTotalRecebiveisLiquidados':
          instance.quantidadeTotalRecebiveisLiquidados,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geral_carteira_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeralCarteiraModel _$GeralCarteiraModelFromJson(Map<String, dynamic> json) =>
    GeralCarteiraModel(
      valorTotalRecebiveisEmAberto:
          (json['valorTotalRecebiveisEmAberto'] as num).toDouble(),
      valorTotalRecebiveisAVencer:
          (json['valorTotalRecebiveisAVencer'] as num).toDouble(),
      valorTotalRecebiveisVencidos:
          (json['valorTotalRecebiveisVencidos'] as num).toDouble(),
      valorTotalRecebiveisLiquidados:
          (json['valorTotalRecebiveisLiquidados'] as num).toDouble(),
      quantidadeTotalRecebiveis:
          (json['quantidadeTotalRecebiveis'] as num).toInt(),
      quantidadeTotalRecebiveisAVencer:
          (json['quantidadeTotalRecebiveisAVencer'] as num).toInt(),
      quantidadeTotalRecebiveisVencidos:
          (json['quantidadeTotalRecebiveisVencidos'] as num).toInt(),
      quantidadeTotalRecebiveisLiquidados:
          (json['quantidadeTotalRecebiveisLiquidados'] as num).toInt(),
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

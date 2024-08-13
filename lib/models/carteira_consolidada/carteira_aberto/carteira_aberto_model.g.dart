// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira_aberto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarteiraAbertoModel _$CarteiraAbertoModelFromJson(Map<String, dynamic> json) =>
    CarteiraAbertoModel(
      valorTotalRecebiveisEmAberto:
          (json['valorTotalRecebiveisEmAberto'] as num).toDouble(),
      valorTotalRecebiveisAVencer:
          (json['valorTotalRecebiveisAVencer'] as num).toDouble(),
      valorTotalRecebiveisVencidos:
          (json['valorTotalRecebiveisVencidos'] as num).toDouble(),
      quantidadeTotalRecebiveisAVencer:
          (json['quantidadeTotalRecebiveisAVencer'] as num).toInt(),
      quantidadeTotalRecebiveisVencidos:
          (json['quantidadeTotalRecebiveisVencidos'] as num).toInt(),
    );

Map<String, dynamic> _$CarteiraAbertoModelToJson(
        CarteiraAbertoModel instance) =>
    <String, dynamic>{
      'valorTotalRecebiveisEmAberto': instance.valorTotalRecebiveisEmAberto,
      'valorTotalRecebiveisAVencer': instance.valorTotalRecebiveisAVencer,
      'valorTotalRecebiveisVencidos': instance.valorTotalRecebiveisVencidos,
      'quantidadeTotalRecebiveisAVencer':
          instance.quantidadeTotalRecebiveisAVencer,
      'quantidadeTotalRecebiveisVencidos':
          instance.quantidadeTotalRecebiveisVencidos,
    };

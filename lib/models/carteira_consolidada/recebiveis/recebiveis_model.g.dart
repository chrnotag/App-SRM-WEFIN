// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recebiveis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecebiveisModel _$RecebiveisModelFromJson(Map<String, dynamic> json) =>
    RecebiveisModel(
      recebiveis: (json['recebiveis'] as List<dynamic>)
          .map((e) => Recebivel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecebiveisModelToJson(RecebiveisModel instance) =>
    <String, dynamic>{
      'recebiveis': instance.recebiveis,
    };

Recebivel _$RecebivelFromJson(Map<String, dynamic> json) => Recebivel(
      sigla: json['sigla'] as String,
      valorTotalAVencer: (json['valorTotalAVencer'] as num).toDouble(),
      valorTotalAVencerPorcentagem:
          (json['valorTotalAVencerPorcentagem'] as num?)?.toDouble(),
      valorTotalVencido: (json['valorTotalVencido'] as num).toDouble(),
      valorTotalVencidoPorcentagem:
          (json['valorTotalVencidoPorcentagem'] as num?)?.toDouble(),
      saldoDevedor: (json['saldoDevedor'] as num).toDouble(),
      corProduto: json['corProduto'] as String,
    );

Map<String, dynamic> _$RecebivelToJson(Recebivel instance) => <String, dynamic>{
      'sigla': instance.sigla,
      'valorTotalAVencer': instance.valorTotalAVencer,
      'valorTotalAVencerPorcentagem': instance.valorTotalAVencerPorcentagem,
      'valorTotalVencido': instance.valorTotalVencido,
      'valorTotalVencidoPorcentagem': instance.valorTotalVencidoPorcentagem,
      'saldoDevedor': instance.saldoDevedor,
      'corProduto': instance.corProduto,
    };

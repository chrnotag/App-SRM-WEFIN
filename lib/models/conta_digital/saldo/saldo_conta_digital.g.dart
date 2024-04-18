// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saldo_conta_digital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaldoContaDigitalModel _$SaldoContaDigitalModelFromJson(
        Map<String, dynamic> json) =>
    SaldoContaDigitalModel(
      dataSaldo: json['dataSaldo'] as String,
      saldoEmConta: (json['saldoEmConta'] as num).toDouble(),
      saldoBloqueado: (json['saldoBloqueado'] as num).toDouble(),
      saldoTotal: (json['saldoTotal'] as num).toDouble(),
    );

Map<String, dynamic> _$SaldoContaDigitalModelToJson(
        SaldoContaDigitalModel instance) =>
    <String, dynamic>{
      'dataSaldo': instance.dataSaldo,
      'saldoEmConta': instance.saldoEmConta,
      'saldoBloqueado': instance.saldoBloqueado,
      'saldoTotal': instance.saldoTotal,
    };

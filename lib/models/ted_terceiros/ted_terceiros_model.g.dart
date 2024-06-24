// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ted_terceiros_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TedTerceirosModel _$TedTerceirosModelFromJson(Map<String, dynamic> json) =>
    TedTerceirosModel(
      codigo: json['codigo'] as int,
      codigoCedente: json['codigoCedente'] as int,
      idInstrucaoParametrosProcessamento:
          json['idInstrucaoParametrosProcessamento'] as int,
      identificadorFavorecido: json['identificadorFavorecido'] as String,
      nomeFavorecido: json['nomeFavorecido'] as String,
      statusAprovacaoCedente: json['statusAprovacaoCedente'] as String,
      statusTransferencia: json['statusTransferencia'] as String,
      valor: json['valor'] as String,
      dataEfetivacao: DateTime.parse(json['dataEfetivacao'] as String),
      tipoTransferencia: json['tipoTransferencia'] as int,
      clienteAprovacao: json['clienteAprovacao'] as String,
      dataClienteAprovacao: json['dataClienteAprovacao'] as String,
      codigoTransacao: json['codigoTransacao'] as String,
    );

Map<String, dynamic> _$TedTerceirosModelToJson(TedTerceirosModel instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'codigoCedente': instance.codigoCedente,
      'idInstrucaoParametrosProcessamento':
          instance.idInstrucaoParametrosProcessamento,
      'identificadorFavorecido': instance.identificadorFavorecido,
      'nomeFavorecido': instance.nomeFavorecido,
      'statusAprovacaoCedente': instance.statusAprovacaoCedente,
      'statusTransferencia': instance.statusTransferencia,
      'valor': instance.valor,
      'dataEfetivacao': instance.dataEfetivacao.toIso8601String(),
      'tipoTransferencia': instance.tipoTransferencia,
      'clienteAprovacao': instance.clienteAprovacao,
      'dataClienteAprovacao': instance.dataClienteAprovacao,
      'codigoTransacao': instance.codigoTransacao,
    };

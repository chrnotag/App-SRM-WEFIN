// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ted_terceiros_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TedTerceirosModel _$TedTerceirosModelFromJson(Map<String, dynamic> json) =>
    TedTerceirosModel(
      saldo: (json['saldo'] as num).toDouble(),
      listaBancos: (json['listaBancos'] as List<dynamic>)
          .map((e) => ListaBanco.fromJson(e as Map<String, dynamic>))
          .toList(),
      saldoInsuficiente: json['saldoInsuficiente'] as bool,
      transferencias: (json['transferencias'] as List<dynamic>)
          .map((e) => Transferencia.fromJson(e as Map<String, dynamic>))
          .toList(),
      valorTarifaTedTerceiros:
          (json['valorTarifaTedTerceiros'] as num).toDouble(),
    );

Map<String, dynamic> _$TedTerceirosModelToJson(TedTerceirosModel instance) =>
    <String, dynamic>{
      'saldo': instance.saldo,
      'listaBancos': instance.listaBancos,
      'saldoInsuficiente': instance.saldoInsuficiente,
      'transferencias': instance.transferencias,
      'valorTarifaTedTerceiros': instance.valorTarifaTedTerceiros,
    };

ListaBanco _$ListaBancoFromJson(Map<String, dynamic> json) => ListaBanco(
      bcecodigo: json['bcecodigo'] as String,
      bcenome: json['bcenome'] as String,
    );

Map<String, dynamic> _$ListaBancoToJson(ListaBanco instance) =>
    <String, dynamic>{
      'bcecodigo': instance.bcecodigo,
      'bcenome': instance.bcenome,
    };

Transferencia _$TransferenciaFromJson(Map<String, dynamic> json) =>
    Transferencia(
      codigo: json['codigo'] as int,
      codigoCedente: json['codigoCedente'] as int?,
      idInstrucaoParametrosProcessamento:
          json['idInstrucaoParametrosProcessamento'] as int,
      identificadorFavorecido: json['identificadorFavorecido'] as String,
      nomeFavorecido: json['nomeFavorecido'] as String,
      statusAprovacaoCedente: json['statusAprovacaoCedente'] as String,
      statusTransferencia:
          $enumDecode(_$TedTerceirosEnumEnumMap, json['statusTransferencia']),
      valor: json['valor'] as String,
      dataEfetivacao: json['dataEfetivacao'] == null
          ? null
          : DateTime.parse(json['dataEfetivacao'] as String),
      tipoTransferencia: json['tipoTransferencia'] as int,
      clienteAprovacao: json['clienteAprovacao'] as String?,
      dataClienteAprovacao: json['dataClienteAprovacao'] as String?,
      codigoTransacao: json['codigoTransacao'] as String?,
    );

Map<String, dynamic> _$TransferenciaToJson(Transferencia instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'codigoCedente': instance.codigoCedente,
      'idInstrucaoParametrosProcessamento':
          instance.idInstrucaoParametrosProcessamento,
      'identificadorFavorecido': instance.identificadorFavorecido,
      'nomeFavorecido': instance.nomeFavorecido,
      'statusAprovacaoCedente': instance.statusAprovacaoCedente,
      'statusTransferencia':
          _$TedTerceirosEnumEnumMap[instance.statusTransferencia]!,
      'valor': instance.valor,
      'dataEfetivacao': instance.dataEfetivacao?.toIso8601String(),
      'tipoTransferencia': instance.tipoTransferencia,
      'clienteAprovacao': instance.clienteAprovacao,
      'dataClienteAprovacao': instance.dataClienteAprovacao,
      'codigoTransacao': instance.codigoTransacao,
    };

const _$TedTerceirosEnumEnumMap = {
  TedTerceirosEnum.PARA_APROVACAO: 'PARA_APROVACAO',
  TedTerceirosEnum.PAGO: 'PAGO',
  TedTerceirosEnum.SOLICITADO: 'SOLICITADO',
  TedTerceirosEnum.REJEITADO: 'REJEITADO',
};

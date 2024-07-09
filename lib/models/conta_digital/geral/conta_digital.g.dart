// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conta_digital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContaDigitalModel _$ContaDigitalModelFromJson(Map<String, dynamic> json) =>
    ContaDigitalModel(
      documentoTitular: json['documentoTitular'] as String,
      idConta: json['idConta'] as int,
      agencia: json['agencia'] as String,
      conta: json['conta'] as String,
      tipoConta: json['tipoConta'] as String,
      centroCusto:
          CentroCusto.fromJson(json['centroCusto'] as Map<String, dynamic>),
      nome: json['nome'] as String,
      codigo: json['codigo'] as String,
    );

Map<String, dynamic> _$ContaDigitalModelToJson(ContaDigitalModel instance) =>
    <String, dynamic>{
      'documentoTitular': instance.documentoTitular,
      'idConta': instance.idConta,
      'agencia': instance.agencia,
      'conta': instance.conta,
      'tipoConta': instance.tipoConta,
      'centroCusto': instance.centroCusto,
      'nome': instance.nome,
      'codigo': instance.codigo,
    };

CentroCusto _$CentroCustoFromJson(Map<String, dynamic> json) => CentroCusto(
      codigo: json['codigo'] as String,
      nome: json['nome'] as String,
    );

Map<String, dynamic> _$CentroCustoToJson(CentroCusto instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'nome': instance.nome,
    };

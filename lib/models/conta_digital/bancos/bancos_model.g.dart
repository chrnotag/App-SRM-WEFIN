// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bancos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BancosModel _$BancosModelFromJson(Map<String, dynamic> json) => BancosModel(
      identificador: json['identificador'] as int?,
      codigo: json['codigo'] as String,
      nome: json['nome'] as String,
      ispb: json['ispb'] as String,
    );

Map<String, dynamic> _$BancosModelToJson(BancosModel instance) =>
    <String, dynamic>{
      'identificador': instance.identificador,
      'codigo': instance.codigo,
      'nome': instance.nome,
      'ispb': instance.ispb,
    };

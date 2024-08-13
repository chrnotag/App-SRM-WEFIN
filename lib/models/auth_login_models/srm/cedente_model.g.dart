// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cedente_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CedenteModel _$CedenteModelFromJson(Map<String, dynamic> json) => CedenteModel(
      identificador: json['identificador'] as String,
      nome: json['nome'] as String,
      assinaturaPendente: (json['assinaturaPendente'] as num).toInt(),
    );

Map<String, dynamic> _$CedenteModelToJson(CedenteModel instance) =>
    <String, dynamic>{
      'identificador': instance.identificador,
      'nome': instance.nome,
      'assinaturaPendente': instance.assinaturaPendente,
    };

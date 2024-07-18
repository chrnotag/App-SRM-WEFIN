// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versao_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersaoModel _$VersaoModelFromJson(Map<String, dynamic> json) => VersaoModel(
      versao: json['versao'] as String,
      sistemaOperacional: json['sistemaOperacional'] as String,
      plataforma: json['plataforma'] as String,
    );

Map<String, dynamic> _$VersaoModelToJson(VersaoModel instance) =>
    <String, dynamic>{
      'versao': instance.versao,
      'sistemaOperacional': instance.sistemaOperacional,
      'plataforma': instance.plataforma,
    };

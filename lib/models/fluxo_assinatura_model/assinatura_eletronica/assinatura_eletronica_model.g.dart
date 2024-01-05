// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assinatura_eletronica_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssinaturaEletronicaModel _$AssinaturaEletronicaModelFromJson(
        Map<String, dynamic> json) =>
    AssinaturaEletronicaModel(
      idAssinaturaDigital: json['idAssinaturaDigital'] as int,
      codigoEmail: json['codigoEmail'] as String,
      deslocamentoFusoHorarioUsuario:
          json['deslocamentoFusoHorarioUsuario'] as String,
      evidencias:
          Evidencias.fromJson(json['evidencias'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssinaturaEletronicaModelToJson(
        AssinaturaEletronicaModel instance) =>
    <String, dynamic>{
      'idAssinaturaDigital': instance.idAssinaturaDigital,
      'codigoEmail': instance.codigoEmail,
      'deslocamentoFusoHorarioUsuario': instance.deslocamentoFusoHorarioUsuario,
      'evidencias': instance.evidencias,
    };

Evidencias _$EvidenciasFromJson(Map<String, dynamic> json) => Evidencias(
      geolocalizacao: Geolocalizacao.fromJson(
          json['geolocalizacao'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EvidenciasToJson(Evidencias instance) =>
    <String, dynamic>{
      'geolocalizacao': instance.geolocalizacao,
    };

Geolocalizacao _$GeolocalizacaoFromJson(Map<String, dynamic> json) =>
    Geolocalizacao(
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      precisao: json['precisao'] as String,
    );

Map<String, dynamic> _$GeolocalizacaoToJson(Geolocalizacao instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'precisao': instance.precisao,
    };

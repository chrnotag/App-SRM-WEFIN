// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalizar_assinatura_eletronica_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalizarAssinaturaEletronicaModel _$FinalizarAssinaturaEletronicaModelFromJson(
        Map<String, dynamic> json) =>
    FinalizarAssinaturaEletronicaModel(
      idAssinaturaDigital: json['idAssinaturaDigital'] as int,
      codigoOperacao: json['codigoOperacao'] as int,
      deslocamentoFusoHorarioUsuario:
          json['deslocamentoFusoHorarioUsuario'] as String,
      evidencias:
          Evidencias.fromJson(json['evidencias'] as Map<String, dynamic>),
      codigoEmail: json['codigoEmail'] as String,
      ticket: json['ticket'] as String,
      chaveDocumento: json['chaveDocumento'] as String,
      idDocumentoLacuna: json['idDocumentoLacuna'] as String,
    );

Map<String, dynamic> _$FinalizarAssinaturaEletronicaModelToJson(
        FinalizarAssinaturaEletronicaModel instance) =>
    <String, dynamic>{
      'idAssinaturaDigital': instance.idAssinaturaDigital,
      'codigoOperacao': instance.codigoOperacao,
      'deslocamentoFusoHorarioUsuario': instance.deslocamentoFusoHorarioUsuario,
      'evidencias': instance.evidencias,
      'codigoEmail': instance.codigoEmail,
      'ticket': instance.ticket,
      'chaveDocumento': instance.chaveDocumento,
      'idDocumentoLacuna': instance.idDocumentoLacuna,
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

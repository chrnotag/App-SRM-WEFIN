// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta_inic_ass_eletronica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseInicAssinaturaEletronica _$ResponseInicAssinaturaEletronicaFromJson(
        Map<String, dynamic> json) =>
    ResponseInicAssinaturaEletronica(
      ticket: json['ticket'] as String,
      chaveDocumento: json['chaveDocumento'] as String,
      idDocumentoLacuna: json['idDocumentoLacuna'] as String,
    );

Map<String, dynamic> _$ResponseInicAssinaturaEletronicaToJson(
        ResponseInicAssinaturaEletronica instance) =>
    <String, dynamic>{
      'ticket': instance.ticket,
      'chaveDocumento': instance.chaveDocumento,
      'idDocumentoLacuna': instance.idDocumentoLacuna,
    };

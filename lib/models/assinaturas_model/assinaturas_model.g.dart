// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assinaturas_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssinaturasModel _$AssinaturasModelFromJson(Map<String, dynamic> json) =>
    AssinaturasModel(
      codigoOperacao: json['codigoOperacao'] as int,
      statusAssinaturaDigital: json['statusAssinaturaDigital'] as String,
      siglaProduto: json['siglaProduto'] as String,
      statusOperacao: json['statusOperacao'] as String,
      valorBruto: json['valorBruto'] as int,
      valorLiquido: (json['valorLiquido'] as num).toDouble(),
      dataOperacao: DateTime.parse(json['dataOperacao'] as String),
      urlAssinador: json['urlAssinador'] as String,
      assinantes: (json['assinantes'] as List<dynamic>)
          .map((e) => Assinante.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssinaturasModelToJson(AssinaturasModel instance) =>
    <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'statusAssinaturaDigital': instance.statusAssinaturaDigital,
      'siglaProduto': instance.siglaProduto,
      'statusOperacao': instance.statusOperacao,
      'valorBruto': instance.valorBruto,
      'valorLiquido': instance.valorLiquido,
      'dataOperacao': instance.dataOperacao.toIso8601String(),
      'urlAssinador': instance.urlAssinador,
      'assinantes': instance.assinantes,
    };

Assinante _$AssinanteFromJson(Map<String, dynamic> json) => Assinante(
      nomeAssinante: json['nomeAssinante'] as String,
      identificadorAssinante: json['identificadorAssinante'] as String,
      informacoesAssinante: (json['informacoesAssinante'] as List<dynamic>)
          .map((e) => InformacaoAssinante.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssinanteToJson(Assinante instance) => <String, dynamic>{
      'nomeAssinante': instance.nomeAssinante,
      'identificadorAssinante': instance.identificadorAssinante,
      'informacoesAssinante': instance.informacoesAssinante,
    };

InformacaoAssinante _$InformacaoAssinanteFromJson(Map<String, dynamic> json) =>
    InformacaoAssinante(
      papeis:
          (json['papeis'] as List<dynamic>).map((e) => e as String).toList(),
      documentos: (json['documentos'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      identificadorAssinador: json['identificadorAssinador'] as String,
      nomeProcurador: json['nomeProcurador'] as String,
      tipoAssinatura: json['tipoAssinatura'] as String,
      dataAssinatura: json['dataAssinatura'] as String,
      statusAssinatura: json['statusAssinatura'] as String,
    );

Map<String, dynamic> _$InformacaoAssinanteToJson(
        InformacaoAssinante instance) =>
    <String, dynamic>{
      'papeis': instance.papeis,
      'documentos': instance.documentos,
      'identificadorAssinador': instance.identificadorAssinador,
      'nomeProcurador': instance.nomeProcurador,
      'tipoAssinatura': instance.tipoAssinatura,
      'dataAssinatura': instance.dataAssinatura,
      'statusAssinatura': instance.statusAssinatura,
    };

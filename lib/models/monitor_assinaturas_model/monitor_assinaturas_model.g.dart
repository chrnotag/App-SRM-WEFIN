// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor_assinaturas_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonitorAssinaturasModel _$MonitorAssinaturasModelFromJson(
        Map<String, dynamic> json) =>
    MonitorAssinaturasModel(
      codigoOperacao: json['codigoOperacao'] as int,
      statusAssinaturaDigital: json['statusAssinaturaDigital'] as String,
      siglaProduto: json['siglaProduto'] as String,
      statusOperacao: json['statusOperacao'] as String,
      valorBruto: (json['valorBruto'] as num).toDouble(),
      valorLiquido: (json['valorLiquido'] as num).toDouble(),
      dataOperacao: json['dataOperacao'] as String,
      assinantes: (json['assinantes'] as List<dynamic>)
          .map((e) => Assinante.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MonitorAssinaturasModelToJson(
        MonitorAssinaturasModel instance) =>
    <String, dynamic>{
      'codigoOperacao': instance.codigoOperacao,
      'statusAssinaturaDigital': instance.statusAssinaturaDigital,
      'siglaProduto': instance.siglaProduto,
      'statusOperacao': instance.statusOperacao,
      'valorBruto': instance.valorBruto,
      'valorLiquido': instance.valorLiquido,
      'dataOperacao': instance.dataOperacao,
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
          .map((e) => Documento.fromJson(e as Map<String, dynamic>))
          .toList(),
      identificadorAssinador: json['identificadorAssinador'] as String,
      tipoAssinatura: json['tipoAssinatura'] as String,
      dataAssinatura: json['dataAssinatura'] as String?,
      statusAssinatura: json['statusAssinatura'] as String,
      eCPFAssinador: json['eCPFAssinador'] as bool?,
      nomeProcurador: json['nomeProcurador'] as String?,
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
      'eCPFAssinador': instance.eCPFAssinador,
    };

Documento _$DocumentoFromJson(Map<String, dynamic> json) => Documento(
      idAssinaturaDigital: json['idAssinaturaDigital'] as int,
      nome: json['nome'] as String,
    );

Map<String, dynamic> _$DocumentoToJson(Documento instance) => <String, dynamic>{
      'idAssinaturaDigital': instance.idAssinaturaDigital,
      'nome': instance.nome,
    };

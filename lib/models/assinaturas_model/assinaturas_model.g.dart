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
      dataOperacao: json['dataOperacao'] as String,
      assinantes: (json['assinantes'] as List<dynamic>)
          .map((e) => Assinantes.fromJson(e as Map<String, dynamic>))
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
      'dataOperacao': instance.dataOperacao,
      'assinantes': instance.assinantes,
    };

Assinantes _$AssinantesFromJson(Map<String, dynamic> json) => Assinantes(
      nomeAssinante: json['nomeAssinante'] as String,
      identificadorAssinante: json['identificadorAssinante'] as String,
      informacoesAssinante: (json['informacoesAssinante'] as List<dynamic>)
          .map((e) => InformacaoAssinante.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssinantesToJson(Assinantes instance) =>
    <String, dynamic>{
      'nomeAssinante': instance.nomeAssinante,
      'identificadorAssinante': instance.identificadorAssinante,
      'informacoesAssinante': instance.informacoesAssinante,
    };

InformacaoAssinante _$InformacaoAssinanteFromJson(Map<String, dynamic> json) =>
    InformacaoAssinante(
      papeis:
          (json['papeis'] as List<dynamic>).map((e) => e as String).toList(),
      documentos: (json['documentos'] as List<dynamic>)
          .map((e) => Documentos.fromJson(e as Map<String, dynamic>))
          .toList(),
      identificadorAssinador: json['identificadorAssinador'] as String,
      tipoAssinatura: json['tipoAssinatura'] as String,
      dataAssinatura: json['dataAssinatura'] as String,
      statusAssinatura: json['statusAssinatura'] as String,
      emailAssinador: json['emailAssinador'] as String,
      idRegistroLacuna: json['idRegistroLacuna'] as String,
      eCPFAssinador: json['eCPFAssinador'] as bool,
      idAssinaturaDigital: json['idAssinaturaDigital'] as String,
    );

Map<String, dynamic> _$InformacaoAssinanteToJson(
        InformacaoAssinante instance) =>
    <String, dynamic>{
      'papeis': instance.papeis,
      'documentos': instance.documentos,
      'identificadorAssinador': instance.identificadorAssinador,
      'tipoAssinatura': instance.tipoAssinatura,
      'dataAssinatura': instance.dataAssinatura,
      'statusAssinatura': instance.statusAssinatura,
      'emailAssinador': instance.emailAssinador,
      'idRegistroLacuna': instance.idRegistroLacuna,
      'eCPFAssinador': instance.eCPFAssinador,
      'idAssinaturaDigital': instance.idAssinaturaDigital,
    };

Documentos _$DocumentosFromJson(Map<String, dynamic> json) => Documentos(
      idAssinaturaDigital: json['idAssinaturaDigital'] as int,
      nome: json['nome'] as String,
    );

Map<String, dynamic> _$DocumentosToJson(Documentos instance) =>
    <String, dynamic>{
      'idAssinaturaDigital': instance.idAssinaturaDigital,
      'nome': instance.nome,
    };

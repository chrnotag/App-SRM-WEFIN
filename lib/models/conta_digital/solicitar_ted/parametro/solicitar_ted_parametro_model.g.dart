// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitar_ted_parametro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitarTedParametroModel _$SolicitarTedParametroModelFromJson(
        Map<String, dynamic> json) =>
    SolicitarTedParametroModel(
      valor: (json['valor'] as num).toDouble(),
      tokenConfirmacao: json['tokenConfirmacao'] as String,
      beneficiario:
          Beneficiario.fromJson(json['beneficiario'] as Map<String, dynamic>),
      informacoesAdicionais: json['informacoesAdicionais'] == null
          ? null
          : InformacoesAdicionais.fromJson(
              json['informacoesAdicionais'] as Map<String, dynamic>),
      favoritar: json['favoritar'] as bool,
      data: json['data'] as String,
    );

Map<String, dynamic> _$SolicitarTedParametroModelToJson(
        SolicitarTedParametroModel instance) =>
    <String, dynamic>{
      'valor': instance.valor,
      'tokenConfirmacao': instance.tokenConfirmacao,
      'beneficiario': instance.beneficiario,
      'informacoesAdicionais': instance.informacoesAdicionais,
      'favoritar': instance.favoritar,
      'data': instance.data,
    };

Beneficiario _$BeneficiarioFromJson(Map<String, dynamic> json) => Beneficiario(
      codigoBanco: json['codigoBanco'] as String,
      agencia: json['agencia'] as String,
      conta: json['conta'] as String,
      tipo: json['tipo'] as String,
      documento: json['documento'] as String,
      nome: json['nome'] as String,
    );

Map<String, dynamic> _$BeneficiarioToJson(Beneficiario instance) =>
    <String, dynamic>{
      'codigoBanco': instance.codigoBanco,
      'agencia': instance.agencia,
      'conta': instance.conta,
      'tipo': instance.tipo,
      'documento': instance.documento,
      'nome': instance.nome,
    };

InformacoesAdicionais _$InformacoesAdicionaisFromJson(
        Map<String, dynamic> json) =>
    InformacoesAdicionais(
      codigoFinalidade: json['codigoFinalidade'] as String,
      descricao: json['descricao'] as String,
    );

Map<String, dynamic> _$InformacoesAdicionaisToJson(
        InformacoesAdicionais instance) =>
    <String, dynamic>{
      'codigoFinalidade': instance.codigoFinalidade,
      'descricao': instance.descricao,
    };

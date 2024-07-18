// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitacoes_ted.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitacaoTed _$SolicitacaoTedFromJson(Map<String, dynamic> json) =>
    SolicitacaoTed(
      itens: (json['itens'] as List<dynamic>)
          .map((e) => Iten.fromJson(e as Map<String, dynamic>))
          .toList(),
      valorTotalItens: (json['valorTotalItens'] as num).toDouble(),
    );

Map<String, dynamic> _$SolicitacaoTedToJson(SolicitacaoTed instance) =>
    <String, dynamic>{
      'itens': instance.itens,
      'valorTotalItens': instance.valorTotalItens,
    };

Iten _$ItenFromJson(Map<String, dynamic> json) => Iten(
      valor: (json['valor'] as num).toDouble(),
      descricao: json['descricao'] as String,
      identificador: json['identificador'] as String,
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      beneficiario:
          Beneficiario.fromJson(json['beneficiario'] as Map<String, dynamic>),
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
    );

Map<String, dynamic> _$ItenToJson(Iten instance) => <String, dynamic>{
      'valor': instance.valor,
      'descricao': instance.descricao,
      'identificador': instance.identificador,
      'status': instance.status,
      'beneficiario': instance.beneficiario,
      'dataCriacao': instance.dataCriacao.toIso8601String(),
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

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      codigo: json['codigo'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'codigo': instance.codigo,
      'nome': instance.nome,
      'descricao': instance.descricao,
    };

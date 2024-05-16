// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conta_extrato_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContaExtratoModel _$ContaExtratoModelFromJson(Map<String, dynamic> json) =>
    ContaExtratoModel(
      numeroConta: json['numeroConta'] as String,
      itens: (json['itens'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContaExtratoModelToJson(ContaExtratoModel instance) =>
    <String, dynamic>{
      'numeroConta': instance.numeroConta,
      'itens': instance.itens,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      dataReferencia: DateTime.parse(json['dataReferencia'] as String),
      saldoNaData: (json['saldoNaData'] as num).toDouble(),
      saldoAnterior: (json['saldoAnterior'] as num).toDouble(),
      lancamentos: (json['lancamentos'] as List<dynamic>)
          .map((e) => Lancamento.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'dataReferencia': instance.dataReferencia.toIso8601String(),
      'saldoNaData': instance.saldoNaData,
      'saldoAnterior': instance.saldoAnterior,
      'lancamentos': instance.lancamentos,
    };

Lancamento _$LancamentoFromJson(Map<String, dynamic> json) => Lancamento(
      id: json['id'] as int,
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      evento: Evento.fromJson(json['evento'] as Map<String, dynamic>),
      valor: (json['valor'] as num).toDouble(),
      conta: json['conta'] as String,
      transacao: json['transacao'] as String,
      controleExterno: json['controleExterno'] as String?,
      data: DateTime.parse(json['data'] as String),
      dataCompleta: DateTime.parse(json['dataCompleta'] as String),
      possuiFalha: json['possuiFalha'] as bool,
      marcadores: (json['marcadores'] as List<dynamic>)
          .map((e) => Marcador.fromJson(e as Map<String, dynamic>))
          .toList(),
      adicionais: json['adicionais'] == null
          ? null
          : Adicionais.fromJson(json['adicionais'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LancamentoToJson(Lancamento instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'evento': instance.evento,
      'valor': instance.valor,
      'conta': instance.conta,
      'transacao': instance.transacao,
      'controleExterno': instance.controleExterno,
      'data': instance.data.toIso8601String(),
      'dataCompleta': instance.dataCompleta.toIso8601String(),
      'possuiFalha': instance.possuiFalha,
      'marcadores': instance.marcadores,
      'adicionais': instance.adicionais,
    };

Adicionais _$AdicionaisFromJson(Map<String, dynamic> json) => Adicionais(
      codigoEvento: json['codigoEvento'] as String,
    );

Map<String, dynamic> _$AdicionaisToJson(Adicionais instance) =>
    <String, dynamic>{
      'codigoEvento': instance.codigoEvento,
    };

Evento _$EventoFromJson(Map<String, dynamic> json) => Evento(
      codigo: json['codigo'] as CodigosExtratoEnum,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      natureza: json['natureza'] as String,
    );

Map<String, dynamic> _$EventoToJson(Evento instance) => <String, dynamic>{
      'codigo': instance.codigo,
      'nome': instance.nome,
      'descricao': instance.descricao,
      'natureza': instance.natureza,
    };

Marcador _$MarcadorFromJson(Map<String, dynamic> json) => Marcador(
      chave: json['chave'] as String,
      valor: json['valor'] as String,
    );

Map<String, dynamic> _$MarcadorToJson(Marcador instance) => <String, dynamic>{
      'chave': instance.chave,
      'valor': instance.valor,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      codigo: json['codigo'] as String,
      nome: json['nome'] as String,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'codigo': instance.codigo,
      'nome': instance.nome,
    };

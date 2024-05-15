import 'package:json_annotation/json_annotation.dart';
part 'conta_extrato_model.g.dart';

@JsonSerializable()
class ContaExtratoModel {
  String numeroConta;
  List<Item> itens;

  ContaExtratoModel({
    required this.numeroConta,
    required this.itens,
  });

  factory ContaExtratoModel.fromJson(Map<String, dynamic> json) => _$ContaExtratoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContaExtratoModelToJson(this);
}

@JsonSerializable()
class Item {
  DateTime dataReferencia;
  double saldoNaData;
  double saldoAnterior;
  List<Lancamento> lancamentos;

  Item({
    required this.dataReferencia,
    required this.saldoNaData,
    required this.saldoAnterior,
    required this.lancamentos,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Lancamento {
  int id;
  Status status;
  Evento evento;
  double valor;
  String conta;
  String transacao;
  String? controleExterno;
  DateTime data;
  DateTime dataCompleta;
  bool possuiFalha;
  List<Marcador> marcadores;
  Adicionais? adicionais;

  Lancamento({
    required this.id,
    required this.status,
    required this.evento,
    required this.valor,
    required this.conta,
    required this.transacao,
    this.controleExterno,
    required this.data,
    required this.dataCompleta,
    required this.possuiFalha,
    required this.marcadores,
    this.adicionais,
  });

  factory Lancamento.fromJson(Map<String, dynamic> json) => _$LancamentoFromJson(json);

  Map<String, dynamic> toJson() => _$LancamentoToJson(this);
}

@JsonSerializable()
class Adicionais {
  String codigoEvento;

  Adicionais({
    required this.codigoEvento,
  });

  factory Adicionais.fromJson(Map<String, dynamic> json) => _$AdicionaisFromJson(json);

  Map<String, dynamic> toJson() => _$AdicionaisToJson(this);
}

@JsonSerializable()
class Evento {
  String codigo;
  String nome;
  String descricao;
  String natureza;

  Evento({
    required this.codigo,
    required this.nome,
    required this.descricao,
    required this.natureza,
  });

  factory Evento.fromJson(Map<String, dynamic> json) => _$EventoFromJson(json);

  Map<String, dynamic> toJson() => _$EventoToJson(this);
}

@JsonSerializable()
class Marcador {
  String chave;
  String valor;

  Marcador({
    required this.chave,
    required this.valor,
  });

  factory Marcador.fromJson(Map<String, dynamic> json) => _$MarcadorFromJson(json);

  Map<String, dynamic> toJson() => _$MarcadorToJson(this);
}

@JsonSerializable()
class Status {
  String codigo;
  String nome;

  Status({
    required this.codigo,
    required this.nome,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

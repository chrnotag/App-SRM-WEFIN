
import 'package:json_annotation/json_annotation.dart';
part 'conta_extrato_model.g.dart';
@JsonSerializable()
class ContaExtratoModel {
  DateTime data;
  DateTime rangeInicial;
  DateTime rangeFinal;
  String numeroConta;
  List<Item> itens;

  ContaExtratoModel({
    required this.data,
    required this.rangeInicial,
    required this.rangeFinal,
    required this.numeroConta,
    required this.itens,
  });

  factory ContaExtratoModel.fromJson(Map<String, dynamic> json) => _$ContaExtratoModelFromJson(json);

  Map<String,dynamic> toJson() => _$ContaExtratoModelToJson(this);

}

@JsonSerializable()
class Item {
  DateTime dataReferencia;
  int saldoNaData;
  int saldoAnterior;
  List<Lancamento> lancamentos;

  Item({
    required this.dataReferencia,
    required this.saldoNaData,
    required this.saldoAnterior,
    required this.lancamentos,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String,dynamic> toJson() => _$ItemToJson(this);

}

@JsonSerializable()
class Lancamento {
  int id;
  Status status;
  Evento evento;
  int valor;
  String conta;
  String transacao;
  String controleExterno;
  DateTime data;
  DateTime dataHora;
  Adicionais adicionais;
  bool possuiFalha;
  Detalhe detalhe;
  List<Marcador> marcadores;

  Lancamento({
    required this.id,
    required this.status,
    required this.evento,
    required this.valor,
    required this.conta,
    required this.transacao,
    required this.controleExterno,
    required this.data,
    required this.dataHora,
    required this.adicionais,
    required this.possuiFalha,
    required this.detalhe,
    required this.marcadores,
  });

  factory Lancamento.fromJson(Map<String, dynamic> json) => _$LancamentoFromJson(json);

  Map<String,dynamic> toJson() => _$LancamentoToJson(this);

}

@JsonSerializable()
class Adicionais {
  String codigoEvento;
  int codigoEmpresa;

  Adicionais({
    required this.codigoEvento,
    required this.codigoEmpresa,
  });

  factory Adicionais.fromJson(Map<String, dynamic> json) => _$AdicionaisFromJson(json);

  Map<String,dynamic> toJson() => _$AdicionaisToJson(this);

}

@JsonSerializable()
class Detalhe {
  AdditionalProp additionalProp1;
  AdditionalProp additionalProp2;
  AdditionalProp additionalProp3;

  Detalhe({
    required this.additionalProp1,
    required this.additionalProp2,
    required this.additionalProp3,
  });

  factory Detalhe.fromJson(Map<String, dynamic> json) => _$DetalheFromJson(json);

  Map<String,dynamic> toJson() => _$DetalheToJson(this);

}

@JsonSerializable()
class AdditionalProp {
  AdditionalProp();

  factory AdditionalProp.fromJson(Map<String, dynamic> json) => _$AdditionalPropFromJson(json);

  Map<String,dynamic> toJson() => _$AdditionalPropToJson(this);
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

  Map<String,dynamic> toJson() => _$EventoToJson(this);

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

    Map<String,dynamic> toJson() => _$MarcadorToJson(this);
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

  Map<String,dynamic> toJson() => _$StatusToJson(this);

}
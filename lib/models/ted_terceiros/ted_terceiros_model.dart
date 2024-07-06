import 'package:json_annotation/json_annotation.dart';

part 'ted_terceiros_model.g.dart';

@JsonSerializable()
class TedTerceirosModel {
  final double saldo;
  final List<ListaBanco> listaBancos;
  final bool saldoInsuficiente;
  final List<Transferencia> transferencias;
  final double valorTarifaTedTerceiros;

  TedTerceirosModel({
    required this.saldo,
    required this.listaBancos,
    required this.saldoInsuficiente,
    required this.transferencias,
    required this.valorTarifaTedTerceiros,
  });

  factory TedTerceirosModel.fromJson(Map<String, dynamic> json) => _$TedTerceirosModelFromJson(json);

  Map<String, dynamic> toJson() => _$TedTerceirosModelToJson(this);

}

@JsonSerializable()
class ListaBanco {
  final String bcecodigo;
  final String bcenome;

  ListaBanco({
    required this.bcecodigo,
    required this.bcenome,
  });

  factory ListaBanco.fromJson(Map<String, dynamic> json) => _$ListaBancoFromJson(json);

  Map<String, dynamic> toJson() => _$ListaBancoToJson(this);

}

@JsonSerializable()
class Transferencia {
  final int codigo;
  final int? codigoCedente;
  final int idInstrucaoParametrosProcessamento;
  final String identificadorFavorecido;
  final String nomeFavorecido;
  final String statusAprovacaoCedente;
  final String statusTransferencia;
  final String valor;
  final DateTime? dataEfetivacao;
  final int tipoTransferencia;
  final String? clienteAprovacao;
  final String? dataClienteAprovacao;
  final String? codigoTransacao;

  Transferencia({
    required this.codigo,
    required this.codigoCedente,
    required this.idInstrucaoParametrosProcessamento,
    required this.identificadorFavorecido,
    required this.nomeFavorecido,
    required this.statusAprovacaoCedente,
    required this.statusTransferencia,
    required this.valor,
    required this.dataEfetivacao,
    required this.tipoTransferencia,
    required this.clienteAprovacao,
    required this.dataClienteAprovacao,
    required this.codigoTransacao,
  });
  factory Transferencia.fromJson(Map<String, dynamic> json) => _$TransferenciaFromJson(json);

  Map<String, dynamic> toJson() => _$TransferenciaToJson(this);
}

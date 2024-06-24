import 'package:json_annotation/json_annotation.dart';

part 'ted_terceiros_model.g.dart';

@JsonSerializable()
class TedTerceirosModel {
  final int codigo;
  final int codigoCedente;
  final int idInstrucaoParametrosProcessamento;
  final String identificadorFavorecido;
  final String nomeFavorecido;
  final String statusAprovacaoCedente;
  final String statusTransferencia;
  final String valor;
  final DateTime dataEfetivacao;
  final int tipoTransferencia;
  final String clienteAprovacao;
  final String dataClienteAprovacao;
  final String codigoTransacao;

  TedTerceirosModel({
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
}
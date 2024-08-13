import 'package:json_annotation/json_annotation.dart';

part 'recebiveis_model.g.dart';

@JsonSerializable()
class RecebiveisModel {
  final List<Recebivel> recebiveis;

  RecebiveisModel({
    required this.recebiveis,
  });

  factory RecebiveisModel.fromJson(Map<String, dynamic> json) =>
      _$RecebiveisModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecebiveisModelToJson(this);
}

@JsonSerializable()
class Recebivel {
  final String sigla;
  final double valorTotalAVencer;
  final double? valorTotalAVencerPorcentagem;
  final double valorTotalVencido;
  final double? valorTotalVencidoPorcentagem;
  final double saldoDevedor;
  final String corProduto;

  Recebivel({
    required this.sigla,
    required this.valorTotalAVencer,
    required this.valorTotalAVencerPorcentagem,
    required this.valorTotalVencido,
    required this.valorTotalVencidoPorcentagem,
    required this.saldoDevedor,
    required this.corProduto,
  });

  factory Recebivel.fromJson(Map<String, dynamic> json) =>
      _$RecebivelFromJson(json);

  Map<String, dynamic> toJson() => _$RecebivelToJson(this);
}

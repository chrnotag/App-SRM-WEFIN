import 'package:json_annotation/json_annotation.dart';

part 'monitor_operacoes_model.g.dart';

@JsonSerializable()
class MonitorOperacoesModel {
  int codigoOperacao;
  String statusOperacao;
  String dataOperacao;
  String siglaProduto;
  double valorBruto;
  double valorLiquido;

  MonitorOperacoesModel(
      {required this.codigoOperacao,
      required this.statusOperacao,
      required this.dataOperacao,
      required this.siglaProduto,
      required this.valorBruto,
      required this.valorLiquido});

  factory MonitorOperacoesModel.fromJson(Map<String, dynamic> json) =>
      _$MonitorOperacoesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MonitorOperacoesModelToJson(this);
}

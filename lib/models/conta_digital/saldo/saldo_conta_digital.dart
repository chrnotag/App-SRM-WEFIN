import 'package:json_annotation/json_annotation.dart';
part 'saldo_conta_digital.g.dart';
@JsonSerializable()
class SaldoContaDigitalModel{
  String dataSaldo;
  double saldoEmConta;
  double saldoBloqueado;
  double saldoTotal;
  SaldoContaDigitalModel({required this.dataSaldo, required this.saldoEmConta, required this.saldoBloqueado, required this.saldoTotal});

  factory SaldoContaDigitalModel.fromJson(Map<String, dynamic> json) => _$SaldoContaDigitalModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaldoContaDigitalModelToJson(this);
}
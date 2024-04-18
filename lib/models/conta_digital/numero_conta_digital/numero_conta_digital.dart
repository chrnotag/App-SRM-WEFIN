import 'package:json_annotation/json_annotation.dart';
part 'numero_conta_digital.g.dart';
@JsonSerializable()
class NumeroContaDigital{
  String numeroContaTitular;
  NumeroContaDigital({required this.numeroContaTitular});

  factory NumeroContaDigital.fromJson(Map<String, dynamic> json) => _$NumeroContaDigitalFromJson(json);
  Map<String, dynamic> toJson() => _$NumeroContaDigitalToJson(this);
}
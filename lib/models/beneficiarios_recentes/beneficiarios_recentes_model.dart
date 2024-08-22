import 'package:json_annotation/json_annotation.dart';

part 'beneficiarios_recentes_model.g.dart';

@JsonSerializable()
class BeneficiariosRecentesModel {
  final String codigoBanco;
  final String agencia;
  final String numeroConta;
  final String tipoConta;
  final String identificadorBeneficiario;
  final String nomeBeneficiario;
  final bool favorito;
  final int idBeneficiario;

  BeneficiariosRecentesModel({
    required this.codigoBanco,
    required this.agencia,
    required this.numeroConta,
    required this.tipoConta,
    required this.identificadorBeneficiario,
    required this.nomeBeneficiario,
    required this.favorito,
    required this.idBeneficiario,
  });

  // Factory method to create an instance from JSON
  factory BeneficiariosRecentesModel.fromJson(Map<String, dynamic> json) =>
      _$BeneficiariosRecentesModelFromJson(json);

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => _$BeneficiariosRecentesModelToJson(this);
}

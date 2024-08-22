// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiarios_recentes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiariosRecentesModel _$BeneficiariosRecentesModelFromJson(
        Map<String, dynamic> json) =>
    BeneficiariosRecentesModel(
      codigoBanco: json['codigoBanco'] as String,
      agencia: json['agencia'] as String,
      numeroConta: json['numeroConta'] as String,
      tipoConta: json['tipoConta'] as String,
      identificadorBeneficiario: json['identificadorBeneficiario'] as String,
      nomeBeneficiario: json['nomeBeneficiario'] as String,
      favorito: json['favorito'] as bool,
      idBeneficiario: (json['idBeneficiario'] as num).toInt(),
    );

Map<String, dynamic> _$BeneficiariosRecentesModelToJson(
        BeneficiariosRecentesModel instance) =>
    <String, dynamic>{
      'codigoBanco': instance.codigoBanco,
      'agencia': instance.agencia,
      'numeroConta': instance.numeroConta,
      'tipoConta': instance.tipoConta,
      'identificadorBeneficiario': instance.identificadorBeneficiario,
      'nomeBeneficiario': instance.nomeBeneficiario,
      'favorito': instance.favorito,
      'idBeneficiario': instance.idBeneficiario,
    };

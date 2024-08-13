// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_boleto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadBoletoModel _$DownloadBoletoModelFromJson(Map<String, dynamic> json) =>
    DownloadBoletoModel(
      identificadorSacado: json['identificadorSacado'] as String,
      numerosDocumento: (json['numerosDocumento'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DownloadBoletoModelToJson(
        DownloadBoletoModel instance) =>
    <String, dynamic>{
      'identificadorSacado': instance.identificadorSacado,
      'numerosDocumento': instance.numerosDocumento,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespostaTokenModel _$RespostaTokenModelFromJson(Map<String, dynamic> json) =>
    RespostaTokenModel(
      celular: json['celular'] as String,
      tokenEnviado: json['tokenEnviado'] as bool,
    );

Map<String, dynamic> _$RespostaTokenModelToJson(RespostaTokenModel instance) =>
    <String, dynamic>{
      'celular': instance.celular,
      'tokenEnviado': instance.tokenEnviado,
    };

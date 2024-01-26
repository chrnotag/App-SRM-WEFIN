// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_logado_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      nome: json['nome'] as String,
      usuario: json['usuario'] as String,
      identificadorUsuario: json['identificadorUsuario'] as String,
      identificadorCedente: json['identificadorCedente'] as String,
      token: json['token'] as String,
      tokenType: json['tokenType'] as String?,
      dataExpiraSessao: DateTime.parse(json['dataExpiraSessao'] as String),
      idDevice: json['idDevice'] as String,
      numeroDeSerie: json['numeroDeSerie'] as int?,
      listaCedente: (json['listaCedente'] as List<dynamic>)
          .map((e) => CedenteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      urlTermoUso: json['urlTermoUso'] as String,
      urlPoliticaPrivacidade: json['urlPoliticaPrivacidade'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'usuario': instance.usuario,
      'identificadorUsuario': instance.identificadorUsuario,
      'identificadorCedente': instance.identificadorCedente,
      'token': instance.token,
      'tokenType': instance.tokenType,
      'dataExpiraSessao': instance.dataExpiraSessao.toIso8601String(),
      'idDevice': instance.idDevice,
      'numeroDeSerie': instance.numeroDeSerie,
      'listaCedente': instance.listaCedente,
      'urlTermoUso': instance.urlTermoUso,
      'urlPoliticaPrivacidade': instance.urlPoliticaPrivacidade,
    };

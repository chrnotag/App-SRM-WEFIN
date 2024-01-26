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
      tipoToken: json['tipoToken'] as String,
      dataExpiraSessao: DateTime.parse(json['dataExpiraSessao'] as String),
      idDevice: json['idDevice'] as String,
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
      'tipoToken': instance.tipoToken,
      'dataExpiraSessao': instance.dataExpiraSessao.toIso8601String(),
      'idDevice': instance.idDevice,
      'listaCedente': instance.listaCedente,
      'urlTermoUso': instance.urlTermoUso,
      'urlPoliticaPrivacidade': instance.urlPoliticaPrivacidade,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      usuario: json['usuario'] as String,
      senha: json['senha'] as String,
      tokenNotificacao: json['tokenNotificacao'] as String,
      identificadorCedente: json['identificadorCedente'] as String?,
      idDevice: json['idDevice'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'usuario': instance.usuario,
      'senha': instance.senha,
      'tokenNotificacao': instance.tokenNotificacao,
      'identificadorCedente': instance.identificadorCedente,
      'idDevice': instance.idDevice,
    };

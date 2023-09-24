// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      nomeUsuario: json['nomeUsuario'] as String,
      senha: json['senha'] as String,
      idDevice: json['idDevice'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nomeUsuario': instance.nomeUsuario,
      'senha': instance.senha,
      'idDevice': instance.idDevice,
    };

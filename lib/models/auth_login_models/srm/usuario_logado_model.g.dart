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
      roles: (json['roles'] as List<dynamic>)
          .map((e) => $enumDecode(_$RolesAcessoEnumEnumMap, e))
          .toList(),
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
      'roles': instance.roles.map((e) => _$RolesAcessoEnumEnumMap[e]!).toList(),
    };

const _$RolesAcessoEnumEnumMap = {
  RolesAcessoEnum.ROLE_MONITOR_OPERACOES: 'ROLE_MONITOR_OPERACOES',
  RolesAcessoEnum.ROLE_CONTA_DIGITAL: 'ROLE_CONTA_DIGITAL',
  RolesAcessoEnum.ROLE_TRANSFERENCIA_CONTA_DIGITAL:
      'ROLE_TRANSFERENCIA_CONTA_DIGITAL',
  RolesAcessoEnum.ROLE_APROVACAO_TED_CONTA_GARANTIA:
      'ROLE_APROVACAO_TED_CONTA_GARANTIA',
};

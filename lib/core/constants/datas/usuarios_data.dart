import 'dart:math';

import 'package:faker/faker.dart';
import 'package:modular_study/models/auth_login_models/cedente_model.dart';

import '../../../models/auth_login_models/usuario_logado_model.dart';

class UsuariosData {
  static _randomTokenType() {
    final random = Random();
    const values = <String>['adm', 'user', 'guest'];
    return values[random.nextInt(values.length)];
  }

  static LoginResponse dadosUsuarios = LoginResponse(
      nome: faker.person.name(),
      usuario: faker.person.firstName(),
      identificadorUsuario: faker.person.lastName(),
      token: faker.jwt.secret,
      tokenType: _randomTokenType(),
      dataExpiraSessao: faker.date.dateTime(),
      idDevice: faker.guid.guid(),
      numeroDeSerie: faker.randomGenerator.integer(1000),
      listaCedente: [
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
        CedenteModel(
            identificador: faker.guid.guid(), nome: faker.company.name()),
      ]);
}

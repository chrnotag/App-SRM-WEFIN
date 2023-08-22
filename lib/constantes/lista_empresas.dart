import 'package:faker/faker.dart';

import '../app/models/usuario_logado/cedente_model.dart';

class ListaDeEmpresas {
  ListaDeEmpresas._();

  static List<CedenteModel> listaEmpresas = [
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
    CedenteModel(faker.phoneNumber.us(), faker.company.name().toString()),
  ];
}

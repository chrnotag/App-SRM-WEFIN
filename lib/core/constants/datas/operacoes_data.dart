import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/models/operacoes_model/model_operacao.dart';

class OperacoesData {
  OperacoesData._();

  static List<List<OperacaoModel>> listaOperacoes = [
    [
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Aprovada',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Pendente',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
    ],
    [
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Aprovada',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Pendente',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
    ],
    [
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Aprovada',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Pendente',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
    ],
    [
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Aprovada',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Pendente',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
    ],
    [
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Aprovada',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
      OperacaoModel(
          papeis: [
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
            faker.lorem.words(2).toString(),
          ],
          procurador: '${faker.person.firstName()} ${faker.person.lastName()}',
          situacao: 'Pendente',
          assinantes: [
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}',
            '${faker.person.firstName()} ${faker.person.lastName()}'
          ],
          documentos: [
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
            faker.internet.domainName(),
          ],
          tipoAssinatura: 'Multipla',
          data: DateFormat('dd/MM/yyyy').format(faker.date.dateTime())),
    ]
  ];
}

import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';
import 'package:modular_study/models/operacoes_model/model_operacao.dart';

class OperacoesData {
  OperacoesData._();

  static List<AssinaturasModel> listaOperacoes = [
    AssinaturasModel(
      codigoOperacao: 101,
      statusAssinaturaDigital: "Validada",
      siglaProduto: "Produto A",
      statusOperacao: "EM DIGITAÇÃO",
      valorBruto: 5000,
      valorLiquido: 4500.0,
      dataOperacao: DateTime(2023, 11, 14),
      urlAssinador: "http://assinador.com/url",
      assinantes: [
        Assinante(
          nomeAssinante: "João Silva",
          identificadorAssinante: "ID123",
          informacoesAssinante: [
            InformacaoAssinante(
                papeis: ["Diretor"],
                documentos: ["Documento 1"],
                identificadorAssinador: "IDAss123",
                nomeProcurador: "Ana Santos",
                tipoAssinatura: "Digital",
                dataAssinatura: "2023-11-14",
                statusAssinatura: "EM DIGITAÇÃO"),
          ],
        ),
      ],
    ),
    AssinaturasModel(
      codigoOperacao: 101,
      statusAssinaturaDigital: "Validada",
      siglaProduto: "Produto A",
      statusOperacao: "PAGAMENTO ENVIADO",
      valorBruto: 5000,
      valorLiquido: 4500.0,
      dataOperacao: DateTime(2023, 11, 14),
      urlAssinador: "http://assinador.com/url",
      assinantes: [
        Assinante(
          nomeAssinante: "João Silva",
          identificadorAssinante: "ID123",
          informacoesAssinante: [
            InformacaoAssinante(
                papeis: ["Diretor"],
                documentos: ["Documento 1"],
                identificadorAssinador: "IDAss123",
                nomeProcurador: "Ana Santos",
                tipoAssinatura: "Digital",
                dataAssinatura: "2023-11-14",
                statusAssinatura: "COBRANÇA"),
          ],
        ),
      ],
    ),
    AssinaturasModel(
      codigoOperacao: 101,
      statusAssinaturaDigital: "Validada",
      siglaProduto: "Produto A",
      statusOperacao: "ANY",
      valorBruto: 5000,
      valorLiquido: 4500.0,
      dataOperacao: DateTime(2023, 11, 14),
      urlAssinador: "http://assinador.com/url",
      assinantes: [
        Assinante(
          nomeAssinante: "João Silva",
          identificadorAssinante: "ID123",
          informacoesAssinante: [
            InformacaoAssinante(
                papeis: ["Diretor"],
                documentos: ["Documento 1"],
                identificadorAssinador: "IDAss123",
                nomeProcurador: "Ana Santos",
                tipoAssinatura: "Digital",
                dataAssinatura: "2023-11-14",
                statusAssinatura: "ANY"),
          ],
        ),
      ],
    ),
  ];
}

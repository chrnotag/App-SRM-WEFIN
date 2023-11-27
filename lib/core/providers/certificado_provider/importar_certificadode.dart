import 'dart:io';
import 'dart:typed_data';

import 'package:crosspki/crosspki.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/constants/route_labels.dart';

class ImportarCertificadoProvider extends ChangeNotifier {
  Uint8List _pkcs12 = Uint8List(0);

  Uint8List get pkcs12 => _pkcs12;

  set pkcs12(Uint8List pkcs12Key) {
    _pkcs12 = pkcs12Key;
    notifyListeners();
  }

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  set errorMsg(String? MsgError) {
    _errorMsg = MsgError;
    notifyListeners();
  }

  String? _senhaCertificado;

  String? get senhaCertificado => _senhaCertificado;

  set senhaCertificado(String? senha) {
    _senhaCertificado = senha;
    notifyListeners();
  }

  void limparErro() {
    errorMsg = null;
    notifyListeners();
  }

  Future<void> selecionarArquivoCertificado() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pkcs12', 'p12', 'pfx'],
    );

    if (result == null) {
      Fluttertoast.showToast(msg: "Nenhum arquivo foi selecionado.");
      return;
    }

    PlatformFile file = result.files.first;

    if (file.path == null) {
      Fluttertoast.showToast(msg: "Caminho do arquivo é nulo.");
      return;
    }

    Uint8List fileContent = await File(file.path!).readAsBytes();

    if (fileContent.isEmpty) {
      Fluttertoast.showToast(msg: "Conteúdo do arquivo é vazio.");
      return;
    }
    pkcs12 = fileContent;
    notifyListeners();
  }

  Future<bool> importarCertificado() async {
    try {
      await CrossPki.importPkcs12(pkcs12, senhaCertificado!);
      var certs = await CrossPki.listCertificatesWithKey();
      Modular.to.navigate(AppRoutes.importarCertificadoRoute);
      Fluttertoast.showToast(msg: 'Certificado ${certs.first.subjectDisplayName} importado com sucesso!');
      return true;
    } on CrossPkiException catch (e) {
      switch (e.code) {
        case CrossPkiErrorCodes.wrongPassword:
          errorMsg =
              'Senha Incorreta. Por favor, verifique a senha do certificado e tente novamente.';
          break;
        case CrossPkiErrorCodes.invalidLicense:
          errorMsg =
              'Licença Inválida. Certifique-se de que possui uma licença válida para usar este recurso.';
          break;
        case CrossPkiErrorCodes.certificateNotFound:
          errorMsg =
              'Certificado Não Encontrado. Verifique se o certificado está correto e disponível.';
          break;
        case CrossPkiErrorCodes.keyNotFound:
          errorMsg =
              'Chave Não Encontrada. Não foi possível encontrar a chave correspondente ao certificado fornecido.';
          break;
        default:
          errorMsg =
              'Erro Desconhecido. Ocorreu um problema não identificado. Por favor, entre em contato com o suporte técnico.';
          break;
      }
    }
    return false;
  }
}

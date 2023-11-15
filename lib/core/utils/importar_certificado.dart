import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:crosspki/crosspki.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImportarCertificado {

  static Future<Uint8List?> selecionarArquivoCertificado() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pkcs12', 'p12', 'pfx'],
    );

    if (result == null) {
      log("Nenhum arquivo foi selecionado.");
      return null;
    }

    PlatformFile file = result.files.first;

    if (file.path == null) {
      log("Caminho do arquivo é nulo.");
      return null;
    }

    Uint8List fileContent = await File(file.path!).readAsBytes();

    if (fileContent.isEmpty) {
      log("Conteúdo do arquivo é vazio.");
      return null;
    }

    return fileContent;
  }
  static Future<void> importarCertificado(Uint8List fileContent, String password) async {
    try {
      await CrossPki.importPkcs12(fileContent, password);
      var certs = await CrossPki.listCertificatesWithKey();
      if (certs.isNotEmpty) {
        final userCertificate = certs.first;
        Fluttertoast.showToast(msg: 'Certificado importado: ${userCertificate.issuerName}');
      } else {
        log("Nenhum certificado foi importado.");
      }
    } catch (e) {
      log("Erro ao importar o certificado: $e");
    }
  }

}

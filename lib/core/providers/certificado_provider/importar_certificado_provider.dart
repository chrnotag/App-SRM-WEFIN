import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:crosspki/crosspki.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/views/home/assinaturas/selecionar_certificado.dart';

class ImportarCertificadoProvider extends ChangeNotifier {
  ImportarCertificadoProvider._();

  static final ImportarCertificadoProvider _instance =
      ImportarCertificadoProvider._();

  factory ImportarCertificadoProvider() {
    return _instance;
  }

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

  PKCertificate? _certificadoSelecionado;

  PKCertificate? get certificadoSelecionado => _certificadoSelecionado;

  set certificadoSelecionado(PKCertificate? certificate) {
    _certificadoSelecionado = certificate;
    notifyListeners();
  }

  void desselecionarCertificado() {
    _certificadoSelecionado = null;
  }

  bool alterarCorItemListaCertificado(int index, BuildContext context) {
    PKCertificate certificado = listaCertificados[index];
    if (_certificadoSelecionado != null &&
        _certificadoSelecionado!.thumbprint == certificado.thumbprint) {
      log('ok');
      return true;
    } else {
      log('não ok');
      return false;
    }
  }

  bool isExpirado(PKCertificate certificado) {
    return certificado.validityEnd.isBefore(DateTime.now());
  }

  void selecionarCertificadoAssinar(
      PKCertificate certificado, BuildContext context) async {
    if (isExpirado(certificado)) {
      showDialog(
        context: context,
        builder: (context) => PopUpDeletarCertificado(
                context: context,
                certificado: certificado,
                title: "Certificado Expirado",
                label: "Deseja deletar o certificado?")
            .popUp,
      );
      listaCertificados = await listaCertificadosFuture();
      notifyListeners();
    } else {
      if (certificadoSelecionado != null &&
          certificadoSelecionado!.thumbprint == certificado.thumbprint) {
        certificadoSelecionado = null;
      } else {
        certificadoSelecionado = certificado;
      }
    }
  }

  String? _senhaCertificado;

  String? get senhaCertificado => _senhaCertificado;

  List<PKCertificate> listaCertificados = [];

  Future<List<PKCertificate>> listaCertificadosFuture() async {
    listaCertificados = await CrossPki.listCertificatesWithKey();
    notifyListeners();
    return listaCertificados;
  }

  Future<void> deletarCertificado(String thumbprint) async {
    await CrossPki.removeCertificate(thumbprint);
    listaCertificados
        .removeWhere((element) => element.thumbprint == thumbprint);
    notifyListeners();
  }

  String converterCertificadoBase64() {
    if (certificadoSelecionado != null) {
      return base64Encode(certificadoSelecionado!.encoded);
    } else {
      return "erro";
    }
  }

  set senhaCertificado(String? senha) {
    _senhaCertificado = senha;
    notifyListeners();
  }

  void limparErro() {
    errorMsg = null;
    notifyListeners();
  }

  Future<bool> selecionarArquivoCertificado() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pkcs12', 'p12', 'pfx'],
    );

    if (result == null) {
      Fluttertoast.showToast(msg: "Nenhum arquivo foi selecionado.");
      return false;
    }
    PlatformFile file = result.files.first;

    if (file.path == null) {
      Fluttertoast.showToast(msg: "Caminho do arquivo é nulo.");
      return false;
    }

    Uint8List fileContent = await File(file.path!).readAsBytes();

    if (fileContent.isEmpty) {
      Fluttertoast.showToast(msg: "Conteúdo do arquivo é vazio.");
      return false;
    }
    pkcs12 = fileContent;
    notifyListeners();
    return true;
  }

  Future<bool> importarCertificado(BuildContext context) async {
    limparErro();
    try {
      log('try');
      await CrossPki.importPkcs12(pkcs12, senhaCertificado!);
      var certs = await CrossPki.listCertificatesWithKey();
      if (isExpirado(certs.first)) {
        log('verificando validade');
        deletarCertificado(certs.first.thumbprint);
        Fluttertoast.showToast(
            msg:
                'Certificado ${certs.first.subjectDisplayName} EXPIRADO! A importação foi cancelada.');
      } else {
        log('importado');
        Fluttertoast.showToast(
            msg:
                'Certificado ${certs.first.subjectDisplayName} importado com sucesso!');
        Modular.to.navigate(AppRoutes.assinaturaDigitalRoute);
      }
      log('terminando');
      Modular.to.pop();
      return true;
    } on CrossPkiException catch (e) {
      log('caiu nas exeções');
      switch (e.code) {
        case CrossPkiErrorCodes.wrongPassword:
          log('1');
          errorMsg =
              'Senha Incorreta. Por favor, verifique a senha do certificado e tente novamente.';
          break;
        case CrossPkiErrorCodes.invalidLicense:
          log('2');
          errorMsg =
              'Licença Inválida. Certifique-se de que possui uma licença válida para usar este recurso.';
          break;
        case CrossPkiErrorCodes.certificateNotFound:
          log('3');
          errorMsg =
              'Certificado Não Encontrado. Verifique se o certificado está correto e disponível.';
          break;
        case CrossPkiErrorCodes.keyNotFound:
          log('4');
          errorMsg =
              'Chave Não Encontrada. Não foi possível encontrar a chave correspondente ao certificado fornecido.';
          break;
        default:
          log('4');
          errorMsg =
              'Erro Desconhecido. Ocorreu um problema não identificado. Por favor, entre em contato com o suporte técnico.';
          break;
      }
    } catch (e) {
      log('5');
      errorMsg =
          'Erro Desconhecido. Ocorreu um problema não identificado. Por favor, entre em contato com o suporte técnico.';
      notifyListeners();
    }
    return false;
  }

  void limparDadosCertificados() {
    listaCertificados = [];
    _certificadoSelecionado = null;
    _pkcs12 = Uint8List(0);
    _senhaCertificado = null;
    _errorMsg = null;
  }
}

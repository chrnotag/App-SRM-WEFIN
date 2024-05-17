import 'dart:typed_data';

import 'package:Srm_Asset/core/providers/conta_digital/comprovante_ted/comprovante_ted_impl.dart';
import 'package:flutter/cupertino.dart';
import '../../../implementations_config/api_response.dart';

class ComprovanteTEDProvider extends ChangeNotifier {
  Uint8List? _comprovanteTEDDownloadBites;

  Uint8List? get comprovanteTEDDownloadBites => _comprovanteTEDDownloadBites;

  set comprovanteTEDDownloadBites(Uint8List? bites) {
    _comprovanteTEDDownloadBites = bites;
    notifyListeners();
  }

  Future<ApiResponse<dynamic>>? _comprovanteTEDFuture;

  Future<ApiResponse<dynamic>>? get comprovanteTEDFuture => _comprovanteTEDFuture;

  set comprovanteTEDFuture(Future<ApiResponse<dynamic>>? comprovante) {
    _comprovanteTEDFuture = comprovante;
  }

  Future<void> carregarDados(String codigoTransacao) async {
    comprovanteTEDFuture = ComprovanteTEDImpl.baixar(codigoTransacao);
  }
}

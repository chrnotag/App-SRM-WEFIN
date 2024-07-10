import 'dart:typed_data';

import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_impl.dart';
import 'package:Srm_Asset/models/ted_terceiros/ted_terceiros_model.dart';
import 'package:flutter/cupertino.dart';

class TedTerceirosProvider extends ChangeNotifier {
  TedTerceirosProvider._();

  static final _instance = TedTerceirosProvider._();

  factory TedTerceirosProvider() {
    return _instance;
  }

  Future<ApiResponse<dynamic>>? _futureListaTed;
  Future<ApiResponse<dynamic>>? get futureListaTed => _futureListaTed;
  set futureListaTed(Future<ApiResponse<dynamic>>? dados) =>
      _futureListaTed = dados;

  Future<void> carregarDados() async {
    futureListaTed = TedTerceirosImpl.pegarTransferencias();
    notifyListeners();
  }

  void limparDados(){
    _futureListaTed = null;
    teds = null;
    transferencia = null;
    pdfComprovante = null;
  }

  TedTerceirosModel? _teds;
  TedTerceirosModel? get teds => _teds;
  set teds(TedTerceirosModel? ted) => _teds = ted;

  Transferencia? _transferencia;
  Transferencia? get transferencia => _transferencia;
  set transferencia(Transferencia? transferencia) => _transferencia = transferencia;

  Uint8List? _pdfComprovante;
  Uint8List? get pdfComprovante => _pdfComprovante;
  set pdfComprovante(Uint8List? comprovante) => _pdfComprovante = comprovante;

}

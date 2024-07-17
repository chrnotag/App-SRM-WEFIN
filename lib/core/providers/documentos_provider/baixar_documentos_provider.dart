import 'package:flutter/cupertino.dart';

class BaixarDocumentosProvider extends ChangeNotifier {
  String? _urlDocumento;

  String? get urlDocumento => _urlDocumento;

  set urlDocumento(String? url) {
    _urlDocumento = url;
    notifyListeners();
  }
}

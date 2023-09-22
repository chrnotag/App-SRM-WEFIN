import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  bool _showCardInfo = false;

  get showCardInfo => _showCardInfo;

  expandCardInfo() {
    _showCardInfo = !_showCardInfo;
    notifyListeners();
  }
}

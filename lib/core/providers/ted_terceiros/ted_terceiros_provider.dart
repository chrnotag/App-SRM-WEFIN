import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:flutter/cupertino.dart';

class TedTerceirosProvider extends ChangeNotifier {
  Future<ApiResponse<dynamic>>? _futureListaTed;

  Future<ApiResponse<dynamic>>? get futureListaTed => _futureListaTed;

  set futureListaTed(Future<ApiResponse<dynamic>>? dados) =>
      _futureListaTed = dados;
}

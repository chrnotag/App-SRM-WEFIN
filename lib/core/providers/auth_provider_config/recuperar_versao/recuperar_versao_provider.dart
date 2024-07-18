import 'package:Srm_Asset/core/providers/auth_provider_config/recuperar_versao/recuperar_versao_impl.dart';
import 'package:Srm_Asset/models/versao_model/versao_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/enuns/os.dart';
import '../../../constants/enuns/plataforma_enum.dart';
import '../../../implementations_config/api_response.dart';
import '../../../utils/toast_erro_util.dart';

class RecuperarVersaoProvider extends ChangeNotifier {
  Future<ApiResponse<dynamic>> pegarVersao() async {
    final response = await RecuperarVersaoImpl.recuperar();
    notifyListeners();
    if (response.error == null) {
      versaoAtual = response.data;
    } else {
      showToast('', response);
    }
    return response;
  }

  VersaoModel? _versaoAtual;

  VersaoModel? get versaoAtual => _versaoAtual;

  set versaoAtual(VersaoModel? versao) {
    _versaoAtual = versao;
    notifyListeners();
  }
}

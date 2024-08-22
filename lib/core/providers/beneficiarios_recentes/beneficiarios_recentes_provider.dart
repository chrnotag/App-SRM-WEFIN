import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:Srm_Asset/models/beneficiarios_recentes/beneficiarios_recentes_model.dart';
import 'beneficiarios_recentes_impl.dart';
import 'package:Srm_Asset/core/utils/toast_erro_util.dart';

class BeneficiariosRecentesProvider extends ChangeNotifier {
  List<BeneficiariosRecentesModel> _listaBeneficiarios = [];

  List<BeneficiariosRecentesModel> get listaBeneficiarios => _listaBeneficiarios;

  Future<void> carregarBeneficiariosRecentes() async {
    final response = await BeneficiariosRecentesImpl.recentes();
    if (response.error == null) {
      _listaBeneficiarios = response.data;
      _listaBeneficiarios.sort((a, b) => (b.favorito ? 1 : 0).compareTo(a.favorito ? 1 : 0));
      notifyListeners();
    } else {
      showToast('Erro ao carregar beneficiários recentes', response);
    }
  }

  Future<void> favoritarBeneficiario(BeneficiariosRecentesModel beneficiario) async {
    final response = await BeneficiariosRecentesImpl.favoritar(beneficiario.idBeneficiario);
    if (response.error == null) {
      await carregarBeneficiariosRecentes();
      notifyListeners();
    } else {
      showToast('Erro ao favoritar beneficiário', response);
    }
  }

  Future<void>? _futureDados;
  Future<void>? get futureDados => _futureDados;
  set futureDados(Future<void>? future) {
    _futureDados = future;
    notifyListeners();
  }
}
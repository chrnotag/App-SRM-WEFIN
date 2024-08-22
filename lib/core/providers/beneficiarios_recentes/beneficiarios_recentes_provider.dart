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
      List<BeneficiariosRecentesModel> listaFavoritos = [];
      List<BeneficiariosRecentesModel> listaNaoFavoritos = [];

      // Separar os beneficiários entre favoritos e não favoritos
      for (var beneficiario in response.data) {
        if (beneficiario.favorito) {
          listaFavoritos.add(beneficiario);
        } else {
          listaNaoFavoritos.add(beneficiario);
        }
      }

      // Ordenar os favoritos pela data de última transferência (mais recente primeiro)
      listaFavoritos.sort((a, b) {
        if (a.dataUltimaTransferencia == null && b.dataUltimaTransferencia == null) return 0;
        if (a.dataUltimaTransferencia == null) return 1;
        if (b.dataUltimaTransferencia == null) return -1;
        return b.dataUltimaTransferencia!.compareTo(a.dataUltimaTransferencia!);
      });

      // Ordenar os não favoritos pela data de última transferência (mais recente primeiro)
      listaNaoFavoritos.sort((a, b) {
        if (a.dataUltimaTransferencia == null && b.dataUltimaTransferencia == null) return 0;
        if (a.dataUltimaTransferencia == null) return 1;
        if (b.dataUltimaTransferencia == null) return -1;
        return b.dataUltimaTransferencia!.compareTo(a.dataUltimaTransferencia!);
      });

      // Mesclar as duas listas, primeiro os favoritos e depois os não favoritos
      _listaBeneficiarios = [...listaFavoritos, ...listaNaoFavoritos];

      notifyListeners();
    } else {
      showToast('Erro ao carregar beneficiários recentes', response);
    }
  }


  Future<void> favoritarBeneficiario(BeneficiariosRecentesModel beneficiario) async {
    final response = await BeneficiariosRecentesImpl.favoritar(beneficiario);
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
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_implementation.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  pegarAssinaturas(String identificador) =>
      AssinaturaImpl(identificador: identificador).assinaturas();

  set assinaturas(List<AssinaturasModel> assinaturasModel) {
    separaAssinaturas(assinaturasModel);
    notifyListeners();
  }

  List<AssinaturasModel> _assinados = [];
  List<AssinaturasModel> _naoAssinados = [];

  List<AssinaturasModel> get assinados => _assinados;

  set assinados(List<AssinaturasModel> docs) {
    _assinados = docs;
  }

  List<AssinaturasModel> get naoAssinados => _naoAssinados;

  set naoAssinados(List<AssinaturasModel> docs) {
    _naoAssinados = docs;
  }

  void separaAssinaturas(List<AssinaturasModel> assinaturas) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    for (int i = 0; i < assinaturas.length; i++) {
      bool naoAssinadoPeloUsuario =
          assinaturas[i].assinantes.any((Assinante assinante) {
        return assinante.identificadorAssinante ==
                authProvider.dataUser!.identificadorUsuario &&
            assinante.informacoesAssinante
                .any((info) => info.statusAssinatura != "Assinado");
      });

      if (naoAssinadoPeloUsuario) {
        _naoAssinados.add(assinaturas[i]);
      } else {
        _assinados.add(assinaturas[i]);
      }
    }
    notifyListeners();
  }
}

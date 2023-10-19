import 'package:flutter/material.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_implementation.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  pegarAssinaturas(String identificador) =>
      AssinaturaImpl(identificador: identificador).assinaturas();

  List<AssinaturasModel> _assinaturasModel = [];

  List<AssinaturasModel> get assinaturas => _assinaturasModel;

  set assinaturas(List<AssinaturasModel> assinaturasModel) {
    _assinaturasModel = assinaturasModel;
  }
}

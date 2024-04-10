import '../../flavors.dart';

class VerificarAmbiente{
  static get isSRM{
    return F.name == Flavor.SRM_PRODUCAO.name || F.name == Flavor.SRM_HOMOLOGACAO.name;
  }
}
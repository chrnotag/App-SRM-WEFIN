enum Flavor {
  srm_producao,
  srm_homologacao,
  trust_producao,
  trust_homologacao,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.srm_producao:
        return 'SRM_PRODUCAO';
      case Flavor.srm_homologacao:
        return 'SRM_HOMOLOGACAO';
      case Flavor.trust_producao:
        return 'TRUST_PRODUCAO';
      case Flavor.trust_homologacao:
        return 'TRUST_HOMOLOGACAO';
      default:
        return 'title';
    }
  }

}

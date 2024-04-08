import 'environment_configs/homologacao_config/srm/srm_homologacao_environment.dart';
import 'core/constants/classes_abstratas/envirioment.dart';
import 'environment_configs/homologacao_config/trust/trust_homologacao_environment.dart';
import 'environment_configs/producao_config/srm/srm_producao_environment.dart';
import 'environment_configs/producao_config/trust/trust_producao_environment.dart';

enum Flavor {
  SRM_HOMOLOGACAO(SrmHomologacaoEnvironment()),
  SRM(SrmProducaoEnvironment()),
  TRUST_HOMOLOGACAO(TrustHomologacaoEnvironment()),
  TRUST(TrustProducaoEnvironment());
  final Environment environment;
  const Flavor(this.environment);
  Environment get getEnvironment => this.environment;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';
}

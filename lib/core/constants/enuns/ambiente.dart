import '../classes_abstratas/envirioment.dart';
import '../../../environment_configs/homologacao_config/srm/srm_homologacao_environment.dart';
import '../../../environment_configs/homologacao_config/trust/trust_homologacao_environment.dart';
import '../../../environment_configs/producao_config/srm/srm_producao_environment.dart';
import '../../../environment_configs/producao_config/trust/trust_producao_environment.dart';

enum Ambiente {
  SRM_HOMOLOGACAO(SrmHomologacaoEnvironment()),
  SRM_PRODUCAO(SrmProducaoEnvironment()),
  TRUST_HOMOLOGACAO(TrustHomologacaoEnvironment()),
  TRUST_PRODUCAO(TrustProducaoEnvironment());
  final Environment environment;
  const Ambiente(this.environment);
  Environment get getEnvironment => this.environment;
}
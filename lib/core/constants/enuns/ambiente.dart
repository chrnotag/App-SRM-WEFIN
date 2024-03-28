import '../../../envirioment.dart';
import '../../../environment_configs/homologacao_config/srm/srm_homologacao_environment.dart';
import '../../../environment_configs/homologacao_config/trust/trust_homologacao_environment.dart';
import '../../../environment_configs/producao_config/srm/srm_producao_environment.dart';
import '../../../environment_configs/producao_config/trust/trust_producao_environment.dart';

enum Ambiente {
  SRM_HOMOLOGACAO,
  SRM_PRODUCAO,
  TRUST_HOMOLOGACAO,
  TRUST_PRODUCAO;

  Environment getEnvironment() {
    switch (this) {
      case Ambiente.SRM_HOMOLOGACAO:
        return SrmHomologacaoEnvironment();
      case Ambiente.SRM_PRODUCAO:
        return SrmProducaoEnvironment();
      case Ambiente.TRUST_HOMOLOGACAO:
        return TrustHomologacaoEnvironment();
      case Ambiente.TRUST_PRODUCAO:
        return TrustProducaoEnvironment();
      default:
        return SrmHomologacaoEnvironment();
    }
  }
}

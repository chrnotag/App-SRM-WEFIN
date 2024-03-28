import 'package:Srm_Asset/envirioment.dart';

class TrustHomologacaoEnvironment extends Environment {
  @override
  String get endpoints =>
      'core/constants/environment/homologacao/trust/endpoints.dart';

  @override
  String get tema => 'core/constants/environment/homologacao/trust/tema.dart';

  @override
  String get temaConfig =>
      'core/constants/environment/homologacao/trust/tema_configs.dart';
}

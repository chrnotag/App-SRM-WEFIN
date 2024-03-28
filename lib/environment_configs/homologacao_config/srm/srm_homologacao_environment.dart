import 'package:Srm_Asset/envirioment.dart';

class SrmHomologacaoEnvironment extends Environment {
  @override
  String get endpoints =>
      'core/constants/environment/homologacao/srm/endpoints.dart';

  @override
  String get tema => 'core/constants/environment/homologacao/srm/tema.dart';

  @override
  String get temaConfig =>
      'core/constants/environment/homologacao/srm/tema_configs.dart';
}

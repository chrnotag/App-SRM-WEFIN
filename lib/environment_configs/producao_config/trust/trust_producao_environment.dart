import 'package:Srm_Asset/envirioment.dart';

class TrustProducaoEnvironment extends Environment {
  @override
  String get endpoints =>
      'core/constants/environment/producao/trust/endpoints.dart';

  @override
  String get tema => 'core/constants/environment/producao/trust/tema.dart';

  @override
  String get temaConfig =>
      'core/constants/environment/producao/trust/tema_configs.dart';
}

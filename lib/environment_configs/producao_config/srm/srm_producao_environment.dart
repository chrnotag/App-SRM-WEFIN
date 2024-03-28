import 'package:Srm_Asset/envirioment.dart';

class SrmProducaoEnvironment extends Environment {
  @override
  String get endpoints =>
      'core/constants/environment/producao/srm/endpoints.dart';

  @override
  String get tema => 'core/constants/environment/producao/srm/tema.dart';

  @override
  String get temaConfig =>
      'core/constants/environment/producao/srm/tema_configs.dart';
}

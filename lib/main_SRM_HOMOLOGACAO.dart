import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.SRM_HOMOLOGACAO;
  await runner.main();
}
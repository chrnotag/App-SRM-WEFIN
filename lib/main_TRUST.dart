import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.TRUST_PRODUCAO;
  await runner.main();
}

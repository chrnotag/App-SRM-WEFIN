import 'package:Srm_Asset/core/constants/enuns/ambiente.dart';
import 'package:Srm_Asset/environment_configs/homologacao_config/srm/srm_homologacao_environment.dart';
import 'package:Srm_Asset/environment_configs/homologacao_config/trust/trust_homologacao_environment.dart';
import 'package:Srm_Asset/environment_configs/producao_config/srm/srm_producao_environment.dart';
import 'package:Srm_Asset/environment_configs/producao_config/trust/trust_producao_environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/app_widget.dart';
import 'envirioment.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'modules/app_module.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  FlavorConfig flavorConfig = FlavorConfig();
  String flavorSelecionado = flavorConfig.name ?? Ambiente.SRM_HOMOLOGACAO.name;
  Environment environment = SrmHomologacaoEnvironment();

  if (flavorSelecionado == Ambiente.SRM_HOMOLOGACAO.name) {
    environment = SrmHomologacaoEnvironment();
  } else if (flavorSelecionado == Ambiente.SRM_PRODUCAO.name) {
    environment = SrmProducaoEnvironment();
  } else if (flavorSelecionado == Ambiente.TRUST_HOMOLOGACAO.name) {
    environment = TrustHomologacaoEnvironment();
  } else if (flavorSelecionado == Ambiente.TRUST_PRODUCAO.name) {
    environment = TrustProducaoEnvironment();
  }

  Modular.setNavigatorKey(myNavigatorKey);
  runApp(
    ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => ModularApp(
        module: AppModule(environment),
        child: const AppWidget(),
      ),
    ),
  );
}

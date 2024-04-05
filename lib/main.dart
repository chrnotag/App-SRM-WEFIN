import 'dart:async';
import 'package:Srm_Asset/app_widget.dart';
import 'package:Srm_Asset/environment_configs/homologacao_config/srm/srm_homologacao_environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/classes_abstratas/envirioment.dart';
import 'flavors.dart';
import 'modules/app_module.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

FutureOr<void> main() async {
  Environment environment = F.appFlavor?.getEnvironment ?? SrmHomologacaoEnvironment();
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
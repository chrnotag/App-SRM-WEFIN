import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Srm_Asset/app_widget.dart';

import 'modules/app_module.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();
void main() {
  Modular.setNavigatorKey(myNavigatorKey);
  runApp(ScreenUtilInit(
    designSize:  const Size(540, 960),
    minTextAdapt: true,
    splitScreenMode: true,
    builder:(context, child) => ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  ));
}
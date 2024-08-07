import 'dart:async';
import 'package:Srm_Asset/app_widget.dart';
import 'package:Srm_Asset/core/services/firebase/fcm_service.dart';
import 'package:Srm_Asset/core/services/notifications/notification_service.dart';
import 'package:Srm_Asset/environment_configs/homologacao_config/srm/srm_homologacao_environment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/classes_abstratas/envirioment.dart';
import 'firebase_options.dart';
import 'flavors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'modules/app_module.dart';

final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Environment environment =
      F.appFlavor?.getEnvironment ?? const SrmHomologacaoEnvironment();

  NotificationService notificationService = NotificationService();

  FirebaseMessaginService messaginService = FirebaseMessaginService(notificationService);

  Modular.setNavigatorKey(myNavigatorKey);
  initializeDateFormatting('pt_BR', null).then((_) {
    runApp(
      ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (context, child) => ModularApp(
          module: AppModule(environment, messaginService),
          child: const AppWidget(),
        ),
      ),
    );
  });
}

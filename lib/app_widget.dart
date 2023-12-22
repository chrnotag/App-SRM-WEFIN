import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_srm.dart';
import 'package:modular_study/core/providers/internet_provider.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';
import 'package:modular_study/views/auth/sem_conexao/sem_conexao.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  final SessionProvider sessionProvider = Modular.get<SessionProvider>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      sessionProvider.stopListening();
    }
    if (state == AppLifecycleState.paused) {
      if (Modular.to.path != Modular.initialRoute &&
          Modular.to.path != AppRoutes.forgetPassAuthRoute) {
        sessionProvider.resetListening();
      }
    }
    if (state == AppLifecycleState.resumed) {
      if (Modular.to.path != Modular.initialRoute &&
          Modular.to.path != AppRoutes.forgetPassAuthRoute) {
        sessionProvider.resetListening();
      }
    }
  }

  bool isKeyboardOpen = false;

  @override
  void didChangeMetrics() {
    final value = WidgetsBinding.instance.window.viewInsets.bottom ?? 0;
    bool newKeyboardState = value > 0;

    if (newKeyboardState != isKeyboardOpen) {
      isKeyboardOpen = newKeyboardState;
      if (isKeyboardOpen) {
        sessionProvider.stopListening();
      } else {
        if (Modular.to.path != Modular.initialRoute &&
            Modular.to.path != AppRoutes.forgetPassAuthRoute) {
          sessionProvider.resetListening();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final ConnectivityProvider connectivityProvider =
        context.watch<ConnectivityProvider>();
    connectivityProvider.dispose();
    super.dispose();
  }

  Future<bool> checkInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }

  @override
  Widget build(BuildContext context) {
    final ConnectivityProvider connectivityProvider =
        context.watch<ConnectivityProvider>();
    return StreamBuilder<bool>(
      stream: connectivityProvider.connectionStatusStream,
      initialData: true,
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!) {
          return ScreenUtilInit(
                      designSize: Size(
                        context.width,
                        context.height,
                      ),
                      builder: (context, child) {
                        return const MaterialApp(
                          home: SemConexaoScreen(),
                        );
                      });
        } else {
          return widgetPrincipal(context);
        }
      },
    );
  }

  Widget widgetPrincipal(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (Modular.to.path != Modular.initialRoute &&
            Modular.to.path != AppRoutes.forgetPassAuthRoute) {
          sessionProvider.resetListening();
        }
      },
      child: GestureDetector(
        onLongPress: () {
          if (Modular.to.path != Modular.initialRoute &&
              Modular.to.path != AppRoutes.forgetPassAuthRoute) {
            sessionProvider.stopListening();
          }
        },
        onLongPressUp: () {
          if (Modular.to.path != Modular.initialRoute &&
              Modular.to.path != AppRoutes.forgetPassAuthRoute) {
            sessionProvider.resetListening();
          }
        },
        child: ScreenUtilInit(
                    designSize: Size(
                      context.width,
                      context.height,
                    ),
                    builder: (context, child) {
                      return MaterialApp.router(
                        routerConfig: Modular.routerConfig,
                        theme: ThemeSRM.theme,
                      );
                    }),
      ),
    );
  }
}

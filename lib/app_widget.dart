import 'package:Srm_Asset/core/utils/lista_execao_tempo_sessao.dart';
import 'package:Srm_Asset/envirioment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:Srm_Asset/core/providers/internet_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';

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
      if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
        sessionProvider.resetListening();
      }
    }
    if (state == AppLifecycleState.resumed) {
      if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
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
        if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
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
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return Listener(
      onPointerDown: (event) {
        if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
          sessionProvider.resetListening();
        }
      },
      child: GestureDetector(
        onLongPress: () {
          if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
            sessionProvider.stopListening();
          }
        },
        onLongPressUp: () {
          if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
            sessionProvider.resetListening();
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: Modular.routerConfig,
          theme: themeProvider.temaAtual,
        ),
      ),
    );
  }
}

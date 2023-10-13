import 'dart:developer';
import 'dart:io'
    show
        Platform; //usado para verificar a plataforma atual (android, ios, windows ou mac)

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb; //usado para verificar se esta rodando na web
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_light.dart';
import 'package:modular_study/core/providers/internet_provider.dart';
import 'package:modular_study/core/providers/secao_provider.dart';
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
    ///Abaixo estamos verificando a plataforma em que o app está rodando
    ///Deixarei os comentários in-line para que possa ser de fácil entendimento
    final ConnectivityProvider connectivityProvider =
        context.watch<ConnectivityProvider>();
    return StreamBuilder<bool>(
      stream: connectivityProvider.connectionStatusStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!) {
          return kIsWeb
              ? ScreenUtilInit(
                  designSize: Size(
                    context.width,
                    context.height,
                  ),
                  builder: (context, child) {
                    return const MaterialApp(
                      home: SemConexaoScreen(),
                    );
                  })
              : Platform.isIOS
                  ? ScreenUtilInit(
                      designSize: Size(
                        context.width,
                        context.height,
                      ),
                      builder: (context, child) {
                        return const CupertinoApp(
                          home: SemConexaoScreen(),
                        );
                      })
                  : ScreenUtilInit(
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
        log('tap');
        if (Modular.to.path != Modular.initialRoute &&
            Modular.to.path != AppRoutes.forgetPassAuthRoute) {
          sessionProvider.resetListening();
        }
      },
      child: GestureDetector(
        onLongPress: () {
          log('long press down');
          if (Modular.to.path != Modular.initialRoute &&
              Modular.to.path != AppRoutes.forgetPassAuthRoute) {
            sessionProvider.stopListening();
          }
        },
        onLongPressUp: () {
          log('long press up');
          if (Modular.to.path != Modular.initialRoute &&
              Modular.to.path != AppRoutes.forgetPassAuthRoute) {
            sessionProvider.resetListening();
          }
        },
        child: kIsWeb
            ?
            //kIsWeb é usado para verificar se estamos rodando na web e retorna um bool
            ScreenUtilInit(
                designSize: Size(
                  context.width,
                  context.height,
                ),
                builder: (context, child) {
                  return MaterialApp.router(
                    routerConfig: Modular.routerConfig,
                    theme: ThemeLight.theme_light,
                    debugShowCheckedModeBanner: false,
                  );
                })
            : Platform.isIOS //Verificamos se estamos em um iphone.
                //caso seja um iphone irá retornar o CupertinoApp para ter o padrão de IOS
                ? ScreenUtilInit(
                    designSize: Size(
                      context.width,
                      context.height,
                    ),
                    builder: (context, child) {
                      return CupertinoApp.router(
                        routerConfig: Modular.routerConfig,
                        theme: ThemeLight.cupertinoThemeLight,
                      );
                    })
                //Caso seja falso, retornaremos o padrão MaterialApp que é para android
                : ScreenUtilInit(
                    designSize: Size(
                      context.width,
                      context.height,
                    ),
                    builder: (context, child) {
                      return MaterialApp.router(
                        routerConfig: Modular.routerConfig,
                        theme: ThemeLight.theme_light,
                      );
                    }),
      ),
    );
  }
}

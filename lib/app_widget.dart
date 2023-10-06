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
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_light.dart';
import 'package:modular_study/core/providers/secao_provider.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Abaixo estamos verificando a plataforma em que o app está rodando
    ///Deixarei os comentários in-line para que possa ser de fácil entendimento
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

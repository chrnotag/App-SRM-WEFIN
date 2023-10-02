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
import 'package:modular_study/core/constants/themes/theme_light.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/providers/secao_provider.dart';
import 'package:provider/provider.dart';

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
      Provider.of<AuthProvider>(context).clearDataUser();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Abaixo estamos verificando a plataforma em que o app está rodando
    ///Deixarei os comentários in-line para que possa ser de fácil entendimento
    return kIsWeb
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
                });
  }
}

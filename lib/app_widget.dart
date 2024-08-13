import 'package:Srm_Asset/core/services/firebase/fcm_service.dart';
import 'package:Srm_Asset/core/services/notifications/notification_service.dart';
import 'package:Srm_Asset/core/utils/lista_execao_tempo_sessao.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:Srm_Asset/core/providers/internet_provider.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

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

  // Utilizado para checar notificações que foram enviadas com o app fechado
  void checkNotifications() async {
    await Modular.get<NotificationService>().checkForNotifications();
  }

  // Inicializar o Firebase Messaging
  void initializeFirebaseMessaging() async {
    await Modular.get<FirebaseMessaginService>().initialize();
  }

  Future<void> _requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }


  @override
  void initState() {
    super.initState();
    checkNotifications();
    initializeFirebaseMessaging();
    WidgetsBinding.instance.addObserver(this);
    _requestPermissions();
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

  final Color corBarra = Colors.white;

  @override
  Widget build(BuildContext context) {
    final Environment ambiente = Modular.get<Environment>();
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
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarIconBrightness:
            useWhiteForeground(corBarra) ? Brightness.light : Brightness.dark,
          ),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: Modular.routerConfig,
            theme: ambiente.tema,
          ),
        ),
      ),
    );
  }
}